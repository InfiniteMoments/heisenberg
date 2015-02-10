module AuthHelper
  SECRET_KEY = Rails.application.secrets.secret_key_base

  class InvalidTokenError < StandardError;
  end

  def get_auth_token(user)
    encode({user_id: user.id})
  end

  def encode(payload, exp=20.years.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decoded_payload
    @decoded_payload ||= decode_token[0]
  end

  def decode_token
    @decoded_token ||= JWT.decode(http_auth_header_token, SECRET_KEY)
  end

  def current_user
    if decoded_payload
      @current_user ||= User.find_by(id: decoded_payload[:user_id])
    end
  end

  def validate_token
    begin
      decode_token
    rescue JWT::DecodeError, JWT::ExpiredSignature, InvalidTokenError
      render json: {error: 'Unauthorized'}, status: :unauthorized
    end
  end

  def http_auth_header_token
    authorization = request.headers['Authorization']
    raise InvalidTokenError if authorization.nil?
    authorization.split(' ').last
  end
end