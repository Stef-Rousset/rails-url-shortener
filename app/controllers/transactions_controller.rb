class TransactionsController < ApplicationController
  before_action :set_account, only: %i[new create edit]
  before_action :set_transaction, only: %i[edit update update_checked destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def new
    @transaction = Transaction.new
    authorize @transaction
  end

  def create
    @transaction = Transaction.new(transaction_params)
    authorize @transaction
    @transaction.account = @account
    if @transaction.save
      respond_to do |format|
        format.html { redirect_to account_path(@account), notice: t(:created, name: t(:transaction)) }
        format.turbo_stream { flash.now[:notice] = t(:created, name: t(:transaction)) }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @transaction.update(transaction_params)
      @account = @transaction.account
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = t(:updated, name: t(:transaction)) }
        format.html { redirect_to account_path(@account), notice: t(:updated, t(:transaction)) }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_checked
    @transaction.update(checked: params[:update_checked])
    @account = @transaction.account
    # for the transaction.checked to be updated in transaction partial and use html format
    redirect_to account_path(@account, count: params[:count], checked: params[:checked], category_id: params[:category_id], begin_date: params[:begin_date], end_date: params[:end_date], format: :html)
  end

  def destroy
    @transaction.destroy
    @account = @transaction.account
    @transactions = @account.transactions # needed in destroy.turbo_stream.erb
    @transaction.update_balance_after_destroy
    # logger.debug "balance: #{@account.balance}"
    respond_to do |format|
      format.html { redirect_to account_path(@account), notice: t(:destroyed, name: t(:transaction)) }
      format.turbo_stream { flash.now[:notice] = t(:destroyed, name: t(:transaction)) }
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
    authorize @transaction
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  def not_found
    redirect_to short_urls_path, alert: t('record_not_found', my_object: Transaction.model_name.name, params: params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:payee, :amount, :transaction_type, :description, :date, :checked, :category_id)
  end
end
