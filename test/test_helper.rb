ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include AuthHelper

  # Add more helper methods to be used by all tests here...
  def json
    ActiveSupport::JSON.decode @response.body
  end

  # Logs in the given test user, sets up the header for functional tests
  # Sets up the token for use with helper methods below in integration tests
  def log_in_as(user, options={})
    password = options[:password] || 'password'
    if integration_test?
      post login_path, {username: user.username,
                        password: password}, {'Accept' => Mime::JSON}
      @token = json['token']
    else
      token = get_auth_token(user)
      @request.headers['Authorization'] = "Bearer #{token}"
    end
  end

  # Helper methods to perform requests with authentication token in integration tests
  def get_with_token(path, parameters = nil, headers_or_env = {})
    merge_token_with_headers headers_or_env
    get(path, parameters, merge_token_with_headers(headers_or_env))
  end

  def post_with_token(path, parameters = nil, headers_or_env = {})
    merge_token_with_headers headers_or_env
    post(path, parameters, merge_token_with_headers(headers_or_env))
  end

  def patch_with_token(path, parameters = nil, headers_or_env = {})
    merge_token_with_headers headers_or_env
    patch(path, parameters, merge_token_with_headers(headers_or_env))
  end

  def delete_with_token(path, parameters = nil, headers_or_env = {})
    delete(path, parameters, merge_token_with_headers(headers_or_env))
  end

  private

  # Returns true inside an integration test.
  def integration_test?
    defined?(post_via_redirect)
  end

  def merge_token_with_headers(headers_or_env)
    headers_or_env.merge({:Authorization => "Bearer #{@token}"}) unless @token.nil?
  end
end
