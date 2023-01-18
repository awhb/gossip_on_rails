class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_request,  only: %i[create update destroy]
  before_action :set_post, only: %i[show create update destroy]

  def index
    categories = Category.all
    render json: categories
  end
  
  def filter
    @category = Category.find(params[:id])
    posts = @category.posts
    render json: posts
  end

  def show
    categories = @post.categories
    render json: categories
  end

  def create
    if (@post.user_id == @current_user)
      @category = Category.find_by(name: params[:name])

      if (!@category)
        @category = Category.create(name: params[:name])
      end
      @post.categories<<(@category)
    else 
      render json: {errors: "User token mismatch - try logging out and in again!"}
    end
  end

  def update
    if (@post.user_id == @current_user)
      @category = Category.find_by_id(params[:id])
      if @comment.save
        render json: {message: "Category successfully updated."}, status: 200
      else
          render error: {error: "Error in updating category. Please try again!"}, status: 400
      end
    else 
      render json: {errors: "User token mismatch - try logging out and in again!"}
    end
  end

  def destroy
    if (@post.user_id == @current_user)
      @category = Category.find_by_id(params[:id])
      @post.categories.delete(@category)
      render json: { message: 'Category deleted!' }
    else 
      render json: {errors: "User token mismatch - try logging out and in again!"}
    end
  end

  private

  def set_post
    @post = Post.find_by_id(params[:id])
  end

end
