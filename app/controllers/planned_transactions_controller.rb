class PlannedTransactionsController < ApplicationController
  before_action :set_planned_transaction, only: %i[edit update destroy]

  def index
    @planned_transactions = policy_scope(PlannedTransaction)
  end

  def new
    @planned_transaction = PlannedTransaction.new
    authorize @planned_transaction
  end

  def create
    @planned_transaction = PlannedTransaction.new(planned_transaction_params)
    authorize @planned_transaction
    if @planned_transaction.save
      redirect_to planned_transactions_path, notice: t(:created, name: t(:planned_transaction))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_planned_transaction
    @planned_transaction = PlannedTransaction.find(params[:id])
    authorize @planned_transaction
  end

  def planned_transaction_params
    params.require(:planned_transaction).permit(:payee, :amount, :transaction_type, :description, :start_date, :every, :account_id, :category_id)
  end
end
