class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request,  only: %i[create update destroy]
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
    # TODO: make hidden field for post_id in the create_comments form of frontend
    comment = Comment.new(content: params[:content], post_id: params[:post_id], user_id: @current_user)

    if comment.save
    index()
    else
      render json: {errors: "Comment could not be saved. Please try again!"}, status: :unprocessable_entity
    end
  end

  def update
    if (@comment && @comment.user_id == @current_user)
      @comment.assign_attributes(content: params[:content])
      if @comment.save
        render json: {message: "Comment successfully updated."}, status: 200
      else
          render error: {error: "Error in updating comment. Please try again!"}, status: 400
      end
    else 
      render json: {errors: "User token mismatch - try logging out and in again!"}
    end 
  end

  def destroy
    if (@comment && @comment.user_id == @current_user)
      @comment&.destroy
      render json: { message: 'Comment deleted!' }
    else 
      render json: {errors: "User token mismatch - try logging out and in again!"}
    end
  end

  private

    def set_comment_creator
      @comment = Comment.find_by_id(params[:id])
      @comment_json = @comment.as_json
      @comment_json['creator'] = comment.user.username
    end

end