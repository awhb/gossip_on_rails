class CommentsController < ApplicationController
  before_action :authorize,  only: %i[create update destroy]
  before_action :set_comment_creator, only: %i[update destroy]

  def index
    comments = Comment.where(post_id: params[:post_id])
    amended_comments = comments.map do |comment|
      comment_json = comment.as_json
      comment_json['creator'] = comment.user.username
      comment_json
    end
    render json: amended_comments
  end

  def create

    comment = Comment.new(content: params[:content], post_id: params[:post_id], user_id: @current_user)

    if comment.save
      index()
    else
      render json: {error: "Comment could not be saved. Please try again!"}, status: 400
    end
  end

  def update
    if (@comment && @comment.user_id == @current_user)
      @comment.assign_attributes(content: params[:content])
      if @comment.save
        index()
      else
          render json: {error: "Error in updating comment. Please try again!"}, status: 400
      end
    else 
      render json: {error: "User token mismatch - try logging out and in again!"}
    end 
  end

  def destroy
    if (@comment && @comment.user_id == @current_user)
      @comment&.destroy
      index()
    else 
      render json: {error: "User token mismatch - try logging out and in again!"}
    end
  end

  private

    def set_comment_creator
      @comment = Comment.find_by_id(params[:id])
    end

end