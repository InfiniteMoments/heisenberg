require 'application_responder'

class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::Helpers
  include AuthHelper

  self.responder = ApplicationResponder
  respond_to :json

  before_action :authenticate_request

  private

  # Validate the token and authenticate the current user
  def authenticate_request
    begin
      authenticate_current_user
    rescue JWT::DecodeError, JWT::ExpiredSignature, InvalidTokenError
      render json: {error: 'Unauthorized'}, status: :unauthorized
    end
  end
end
