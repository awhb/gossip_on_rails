class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy]

  def index
    comment = Comment.all.order(created_at: :desc)
    render json: comment
  end

  def create
    # add ids to comment_params (either in frontend or here)
    comment = Comment.create!(comment_params)
    if comment
      render json: comment
    else
      render json: comment.errors
    end
  end

  def destroy
    @comment&.destroy
    render json: { message: 'Comment deleted!' }
  end

  private

  def comment_params
    params.permit(:content, :user_id, :post_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
