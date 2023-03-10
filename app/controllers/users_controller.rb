class UsersController < ApplicationController
  before_action :authorize, only: %i[update]
  before_action :set_user, only: %i[show update destroy]

  def index
    users = User.all.order(created_at: :desc)
    render json: users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :ok
    else
      render json: { error: 'Username already taken.' }, status: :unprocessable_entity
    end
  end
  
  def update 
    if @user.update(user_params)
      render json: @user
    else
      render json: {error: "Username already taken."}, status: 400
    end
  end

  def destroy
    @user.destroy
    index()
  end

  def login 
    @user = User.find_by(params[:username])

    if @user && @user.authenticate(user_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :ok
    else
      render json: { error: 'Invalid username or password.' }, status: 400
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
