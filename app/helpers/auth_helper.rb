module AuthHelper
  SECRET_KEY = Rails.application.secrets.secret_key_base

  class InvalidTokenError < StandardError;
  end

  # Returns the JWT authentication token for the given user
  def get_auth_token(user)
    encode({user_id: user.id})
  end

  # Returns the JWT token with the encoded payload,
  # expiry defaults to 20 years from now
  def encode(payload, exp=20.years.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  # Returns the payload from the decoded token
  def decoded_payload
    @decoded_payload ||= decode_token[0]
  end

  # Returns the decoded JWT token
  def decode_token
    @decoded_token ||= JWT.decode(http_auth_header_token, SECRET_KEY)
  end

  # Returns the current user from the decoded payload
  def current_user
    if decoded_payload
      # Can't use symbol for hash key, JWT parses it as string
      @current_user ||= User.find_by(id: decoded_payload['user_id'])
    end
  end

  # Returns true if the given user is the current user
  def current_user?(user)
    current_user == user
  end

  # Validates the JWT token in the incoming request header,
  # renders a 401 if token has expired or been tampered with
  def validate_token
    begin
      decode_token
    rescue JWT::DecodeError, JWT::ExpiredSignature, InvalidTokenError
      render json: {error: 'Unauthorized'}, status: :unauthorized
    end
  end

  # Returns the JWT token from the request Authorization header
  def http_auth_header_token
    authorization = request.headers['Authorization']
    raise InvalidTokenError if authorization.nil?
    authorization.split(' ').last
  end
end