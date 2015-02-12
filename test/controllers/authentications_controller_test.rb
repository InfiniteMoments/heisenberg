require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase
  test "should return unauthorized for logout when not logged in" do
    delete :destroy
    assert_response :unauthorized
  end
end
