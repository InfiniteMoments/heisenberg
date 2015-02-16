require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase
  test "should return unauthorized for logout when not logged in" do
    @request.headers['Accept'] = Mime::JSON
    delete :destroy
    assert_response :unauthorized
  end

  test "should return not acceptable for logout if Accept header is not JSON" do
    delete :destroy
    assert_response :not_acceptable
  end
end
