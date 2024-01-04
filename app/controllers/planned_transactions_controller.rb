class PlannedTransactionsController < ApplicationController
  before_action :set_planned_transaction, only: %i[edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @planned_transactions = policy_scope(PlannedTransaction).order(start_date: :desc)
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
    if @planned_transaction.update(planned_transaction_params)
      respond_to do |format|
        format.html { redirect_to planned_transactions_path, notice: t(:updated, name: t(:planned_transaction)) }
        format.turbo_stream { flash.now[:notice] = t(:updated, name: t(:planned_transaction)) }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @planned_transaction.destroy
    @planned_transactions = current_user.accounts.map(&:planned_transactions).flatten.compact # needed in destroy.turbo_stream.erb
    respond_to do |format|
      format.html { redirect_to planned_transactions_path, notice: t(:destroyed, name: t(:planned_transaction)) }
      format.turbo_stream { flash.now[:notice] = t(:destroyed, name: t(:planned_transaction)) }
    end
  end

  private

  def set_planned_transaction
    @planned_transaction = PlannedTransaction.find(params[:id])
    authorize @planned_transaction
  end

  def not_found
    redirect_to accounts_path, alert: t('record_not_found', my_object: PlannedTransaction.model_name.name, params: (params[:id]))
  end

  def planned_transaction_params
    params.require(:planned_transaction).permit(:payee, :amount, :transaction_type, :description, :start_date, :every, :account_id, :category_id)
  end
end
