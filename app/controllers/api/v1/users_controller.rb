class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :set_user, only: %i[show]

  def index
    users = User.all.order(created_at: :desc)
    render json: users
  end

  def search
    users = User.where("username = ?", params[:username])
    render json: users
  end

  def create
    user = User.create!(user_params)
    if user.save
      login()
    else
      render json: {error: 'An error has occurred.'}, status: :unprocessable_entity
    end
    rescue ActiveRecord::RecordNotUnique
      render json: {error: 'The username is already taken.'}, status: :unprocessable_entity
    end
  end

  def show
    render json: @user
  end

  def login
    user = User.find_by(name: params[:username])
    if user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        render json: {token: token, username: user.username}
    else
        render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

end