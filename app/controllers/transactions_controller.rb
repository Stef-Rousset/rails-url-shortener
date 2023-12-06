class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: %i[new create edit]
  before_action :set_transaction, only: %i[edit update update_checked destroy]

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
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
    @transaction.update(checked: params[:checked])
    render json: {}, status: :ok
  end

  def destroy
    @transaction.destroy
    @account = @transaction.account
    @transactions = @account.transactions
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
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  def transaction_params
    params.require(:transaction).permit(:payee, :amount, :transaction_type, :description, :date, :checked, :category_id)
  end
end
