class CategoriesController < ApplicationController

  def index
    #@categories = Category.where(user_id: current_user.id).or(Category.where(user_id: nil))
    @categories = policy_scope(Category)
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      redirect_to categories_path, notice: t(:created, name: t(:category))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize @category
    @category.destroy
    redirect_to categories_path, notice: t(:destroyed, name: t(:category))
  end

  private

  def category_params
    params.require(:category).permit(:name, :user_id)
  end
end
