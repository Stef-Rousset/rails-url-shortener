class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: %i[new create]

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

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    @account = @transaction.account
    @transaction.update_balance_after_destroy
    #logger.debug "balance: #{@account.balance}"
    respond_to do |format|
      format.html { redirect_to account_path(@account), notice: t(:destroyed, name: t(:transaction)) }
      format.turbo_stream { flash.now[:notice] = t(:destroyed, name: t(:transaction)) }
    end
  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  end

  def transaction_params
    params.require(:transaction).permit(:payee, :amount, :transaction_type, :description, :date, :checked, :category_id)
  end
end
