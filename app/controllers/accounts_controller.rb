class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @accounts = Account.where(user_id: current_user.id)
    @total = current_user.accounts_total_sum
  end

  def show
    @transactions = @account.transactions.order(date: :desc, created_at: :desc)
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
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

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def not_found(exception)
    redirect_to accounts_path, alert: t('record_not_found', my_object: Account.model_name.name, params: (params[:id]))
  end

  def account_params
    params.require(:account).permit(:name, :balance, :user_id)
  end
end
