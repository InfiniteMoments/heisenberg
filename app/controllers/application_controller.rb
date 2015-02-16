class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::Helpers
  include AuthHelper

  # Declare all helpers you need in views here
  helper AuthHelper

  before_action :validate_request_content_type
  before_action :validate_request_accept
  before_action :validate_token

  private

  def validate_request_accept
    render :nothing => true, :status => 406 unless /json/ =~ request.headers['Accept']
  end

  def validate_request_content_type
    render :nothing => true, :status => 415 unless /json/ =~ request.headers['Content-Type']
  end
end
