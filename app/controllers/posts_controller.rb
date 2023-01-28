class PostsController < ApplicationController
  before_action :authorize,  only: %i[create update destroy]
  before_action :set_post_creator, only: %i[show update destroy]

  def index
    posts = Post.all
    amended_posts = posts.map do |post|
      post_json = post.as_json
      post_json['creator'] = post.user.username
      post_json
    end
    render json: amended_posts, status: 200
  end

  def show
    render json: @post_json, status: 200
  end

  def create
    post = Post.new(post_params)

    if post.save
      render json: post
    else
      render json: {error: "Post could not be saved. Please try again!"}, status: 400
    end

  end

  def update
    if (@post && @post.user_id == @current_user)
      @post.assign_attributes(post_params)
      if @post.save
        render json: @post, status: 200
      else
          render json: {error: "Error in updating thread. Please try again!"}, status: 400
      end
    else 
      render json: {error: "User token mismatch - try logging out and in again!"}, status: 400
    end 
  end

  def destroy
    if (@post && @post.user_id == @current_user)
      @post&.destroy
      index()
    else 
      render json: {error: "User token mismatch - try logging out and in again!"}, status: 400
    end
  end

  private

  def post_params
    params.require(:post).permit(:id, :title, :content, :categories, :user_id)
  end

  def set_post_creator
    @post = Post.find_by_id(params[:id])
    @post_json = @post.as_json
    @post_json['creator'] = @post.user.username
  end
end