require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase
  def setup
    @request.headers['Accept'] = MIME_JSON
    @request.headers['Content-Type'] = MIME_JSON
  end

  test "should return unauthorized for logout when not logged in" do
    delete :destroy
    assert_response :unauthorized
  end

  test "should return not acceptable for logout if Accept header is not JSON" do
    @request.headers['Accept'] = nil
    delete :destroy
    assert_response :not_acceptable
  end

  test "should return unsupported media type for logout if Content-Type header is not JSON" do
    @request.headers['Content-Type'] = nil
    delete :destroy
    assert_response :unsupported_media_type
  end
end
