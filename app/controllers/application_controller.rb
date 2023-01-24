class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :null_session

  def encode_token(payload) 
    JWT.encode(payload, 'secret')
  end

  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'secret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized_user 
    decoded_token = decode_token()
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @current_user = User.find_by(id: user_id)
    end
  end

  def authorize 
    if !authorized_user 
      render json: { error: 'Not logged in.' }, status: :unauthorized
    end
  end
end

