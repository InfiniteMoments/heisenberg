module AuthHelper
  SECRET_KEY = Rails.application.secrets.secret_key_base

  class InvalidTokenError < StandardError;
  end

  def self.encode(payload, exp=20.years.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decoded_token
    @decoded_token ||= JWT.decode(http_auth_header_token, SECRET_KEY)[0]
  end

  def authenticate_current_user
    if decoded_token
      @current_user ||= User.find_by(id: decoded_token[:user_id])
    end
  end

  # Alias method for better readability and use in controllers elsewhere
  alias_method :current_user, :authenticate_current_user

  def http_auth_header_token
    authorization = request.headers['Authorization']
    raise InvalidTokenError if authorization.nil?
    authorization.split(' ').last
  end
end