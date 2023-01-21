class Api::V1::UsersController < ApplicationController
  before_action :authenticate, except: %i[index, login, create]
  before_action :set_user, only: %i[show, update, destroy]

  def index
    users = User.all.order(created_at: :desc)
    render json: users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {token: user.login}
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end 

  def show
    render json: @user
  end

  def update 
    unless @user.update(user_params)
      render json: {error: @user.errors.full_messages}, status: 503
    end
  end

  def destroy
    @user.destroy
  end

  def login
    user = User.find_by(name: params[:username])
    if user&.valid_password?(params[:password])
        token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
        render json: {token: token, username: user.username}
    else
        render json: { error: 'Invalid username or password.' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
