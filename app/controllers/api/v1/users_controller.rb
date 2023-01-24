class Api::V1::UsersController < ApplicationController
  before_action :authorize, only: %i[update]
  before_action :set_user, only: %i[show update destroy]

  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :ok
    else
      render json: { error: 'Username already taken.' }, status: :unprocessable_entity
    end
  end

  def login 
    @user = User.find_by(username: user_params[:username])

    if @user && @user.authenticate(user_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :ok
    else
      render json: { error: 'Invalid username or password.' }, status: :unprocessable_entity
    end
  end

  def index
    users = User.all.order(created_at: :desc)
    render json: users
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

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
