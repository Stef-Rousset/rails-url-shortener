class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @account = Account.find(params[:account_id])
    @transaction = Transaction.new
  end

  def create
    @account = Account.find(params[:account_id])
    @transaction = Transaction.new(transaction_params)
    @transaction.account = @account
    if @transaction.save
      respond_to do |format|
        format.html { redirect_to account_path(@account), notice: t(:created, name: t(:transaction)) }
        format.turbo_stream { flash.now[:notice] = 'Opération créee !' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:payee, :amount, :transaction_type, :description, :date, :checked, :category_id)
  end
end
