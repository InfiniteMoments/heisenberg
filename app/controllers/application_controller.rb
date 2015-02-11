require 'application_responder'

class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::Helpers
  include AuthHelper

  # Declare all helpers you need in views here
  helper AuthHelper

  self.responder = ApplicationResponder
  respond_to :json

  before_action :validate_token
end
