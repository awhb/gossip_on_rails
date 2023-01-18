class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_request,  only: %i[create update destroy]
  before_action :set_post_creator, only: %i[show update destroy]

  def index
    # method to sort by upvotes?
    categories = Category.distinct.pluck(:name)
    render json: categories
  end

  def show
    categories = Category.where(post_id: params[:post_id])
    render json: categories
  end

  def filter
    # need to do
    posts = Post.where(cat_id: params[:categories.id])

  def create
    if (@category && @post.user_id == @current_user)
      something
    end
    # TODO: make hidden field for post_id in the create_comments form of frontend
    comment = Comment.new(content: params[:content], post_id: params[:post_id], user_id: @current_user)

    if comment.save
    index()
    else
      render json: {errors: "Comment could not be saved. Please try again!"}, status: :unprocessable_entity
    end
  end


  def update
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
