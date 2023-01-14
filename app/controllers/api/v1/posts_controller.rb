class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy]

  def index
    # method to sort by upvotes?
    post = Post.all.order(created_at: :desc)
    render json: post
  end

  def create
    # add user_id to post_params (either in frontend or here)
    post = Post.create!(post_params)
    if post
      render json: post
    else
      render json: post.errors
    end
  end

  def show
    render json: @post
  end

  def destroy
    @post&.destroy
    render json: { message: 'Thread deleted!' }
  end

  private

  def post_params
    # to clarify: need user_id or not?
    params.permit(:title, :content, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
