class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy import upload_data]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @accounts = policy_scope(Account)
    @total = current_user.accounts_total_sum
  end

  def show
    @transactions = @account.transactions.order(date: :desc, created_at: :desc)
    @size = @transactions.size
    @count = 5
    @transactions = @transactions.where(checked: params[:checked]) if params[:checked] != '0' && params[:checked].present?
    @transactions = @transactions.where(category_id: params[:category_id]) if params[:category_id].present?
    if params[:begin_date].present? && params[:end_date].present?
      @transactions = @transactions.where('date >= ?', params[:begin_date]).where('date <= ?', params[:end_date])
    elsif params[:begin_date].present?
      @transactions = @transactions.where('date >= ?', params[:begin_date])
    elsif params[:end_date].present?
      @transactions = @transactions.where('date <= ?', params[:end_date])
    end
    if params[:count].present?
      # if filters or show_more arrow have been used
      # redefine @count with the incremented value of  params[:count]
      @count = @count * params[:count].to_i
      # redefine @size with transactions filtered if filters are used
      @size = @transactions.size if params[:checked].present? || params[:category_id].present? || params[:begin_date].present? || params[:end_date].present?
      @transactions = @transactions.limit(@count)
    else
      # arriving on show, display only 5 transactions
      @transactions = @transactions.limit(@count)
    end

    respond_to do |format|
      format.html
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="transactions.xlsx"' }
      format.turbo_stream
    end
  end

  def new
    @account = Account.new
    authorize @account
  end

  def create
    @account = Account.new(account_params)
    authorize @account
    if @account.save
      redirect_to account_path(@account), notice: t(:created, name: t(:account))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @account.update(account_params)
      redirect_to account_path(@account), notice: t(:updated, name: t(:account))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_path, notice: t(:destroyed, name: t(:account))
  end

  def import
  end

  def upload_data
    @rows = []
    file = params[:excel_file]
    xlsx = Roo::Spreadsheet.open(file, extension: :xlsx)
    count = xlsx.count
    for i in 2..count # we don't want first headers row
      date = xlsx.row(i)[0]
      payee = xlsx.row(i)[1]
      if xlsx.row(i)[2].present? # data is in debit column
        transaction_type = 'debit'
        amount = xlsx.row(i)[2].to_s.gsub(/-/, '').gsub(/,/, '.').to_f.truncate(2)
      else # data is in credit column
        transaction_type = 'credit'
        amount = xlsx.row(i)[3].to_s.gsub(/,/, '.').to_f.truncate(2)
      end
      description = xlsx.row(i)[4]
      if xlsx.row(i)[5].present?
        category_id = Category.find_by(name: xlsx.row(i)[5].capitalize)&.id
      end
      if xlsx.row(i)[6].downcase == 'oui' || xlsx.row(i)[6].downcase == 'yes'
        checked = true
        # no need of else condition because default value is false
      end
      if Transaction.where(account_id: @account.id, amount: amount, transaction_type: transaction_type, date: date).empty? &&
        date.present? && payee.present? && amount.present? && transaction_type.present?
        Transaction.create!(account_id: @account.id,
                            date: date,
                            payee: payee,
                            amount: amount,
                            transaction_type: transaction_type,
                            description: description || nil,
                            category_id: category_id || nil,
                            checked: checked || nil
                            )
      else
        @rows << i
      end
    end
    if @rows.present?
      redirect_to import_account_path(@account), alert: t(:existing_rows, rows: "#{@rows.join(', ')}")
    else
      redirect_to account_path(@account), notice: t(:imported_rows, rows: "#{count}")
    end
  end

  private

  def set_account
    @account = Account.find(params[:id])
    authorize @account

  end

  def not_found
    redirect_to accounts_path, alert: t('record_not_found', my_object: Account.model_name.name, params: (params[:id]))
  end

  def account_params
    params.require(:account).permit(:name, :balance, :user_id)
  end
end
