class ApplicationController < ActionController::Base

  private

  def authenticate
    begin
      @decoded = JWT.decode(request.headers['Authorization'], Rails.application.secrets.secret_key_base)
      @current_user = User.find(@decoded[0]['user_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: 'Unauthorized Request.' }, status: :unauthorized
    end
  end
end
