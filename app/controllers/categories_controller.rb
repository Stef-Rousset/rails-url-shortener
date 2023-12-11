class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.where(user_id: current_user.id).or(Category.where(user_id: nil))
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: t(:created, name: t(:category))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: t(:destroyed, name: t(:category))
  end

  private

  def category_params
    params.require(:category).permit(:name, :user_id)
  end
end
