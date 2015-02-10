require 'application_responder'

class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::Helpers
  include AuthHelper

  self.responder = ApplicationResponder
  respond_to :json

  before_action :validate_token
end
