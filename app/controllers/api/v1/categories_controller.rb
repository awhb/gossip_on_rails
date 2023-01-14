class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: %i[filter destroy]

  def index
    # method to sort by upvotes?
    category = Category.all.order(created_at: :desc)
    render json: category
  end

  def create
    # shift this logic to posts controller
    category = Category.create!(category_params)
    if category
      render json: category
    else
      render json: category.errors
    end
  end

  def filter
    render json: @category
  end

  def destroy
    @category&.destroy
    render json: { message: 'Category deleted!' }
  end

  private

  def category_params
    # to clarify: need user_id or not?
    params.permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
