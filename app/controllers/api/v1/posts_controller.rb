class Api::V1::PostsController < ApplicationController
  before_action :authorize_request,  only: %i[create update destroy]
  before_action :set_post_creator, only: %i[show update destroy]

  def index
    # method to sort?
    post = Post.all.order(created_at: :desc)
    render json: post
  end

  def show
    render json: post_json
  end

  def create
    post = Post.new(title: params[:title], content: params[:content], user_id: @current_user)

    if post.save
      categories = params[:categories]
      categories.each do |name|
        newCat = Category.create(name: name, post_id:@post.id)
      render json: post
    else
      render json: {errors: "Post could not be saved. Please try again!"}, status: :unprocessable_entity
    end
  end

  def update
    if (@post && @post.user_id == @current_user)
      @post.assign_attributes(title: params[:title], content: params[:content])
      if @post.save
        render json: {message: "Thread successfully updated."}, status: 200
      else
          render error: {error: "Error in updating thread. Please try again!"}, status: 400
      end
    else 
      render json: {errors: "User token mismatch - try logging out and in again!"}
    end 
  end

  def destroy
    if (@post && @post.user_id == @current_user)
      @post&.destroy
      render json: { message: 'Thread deleted!' }
    else 
      render json: {errors: "User token mismatch - try logging out and in again!"}
    end
  end

  private

    def set_post_creator
      @post = Post.find(params[:id])
      @post_json = @post.as_json
      @post_json['creator'] = post.user.username
    end
end
