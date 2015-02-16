class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::Helpers
  include AuthHelper

  # Declare all helpers you need in views here
  helper AuthHelper

  before_action :validate_request_format
  before_action :validate_token

  private

  def validate_request_format
    render :nothing => true, :status => 406 unless params[:format] == 'json' || /json/ =~ request.headers['Accept']
  end
end
