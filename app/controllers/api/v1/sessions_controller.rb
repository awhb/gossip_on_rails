class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      payload = { user_id: user.id }
      session = JWT.encode(payload, Rails.application.secrets.secret_key_base)
      render json: { token: session, user: user }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    session = nil
    render json: { message: 'Logged out' }, status: :ok
  end
end
