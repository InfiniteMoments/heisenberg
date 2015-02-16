require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    post login_path, json_encode({username: 'saiaspire', password: 'wrongpassword'}),
         {'Accept' => MIME_JSON, 'Content-Type' => MIME_JSON}
    assert_response :unauthorized
  end

  test "login with valid information" do
    post login_path, json_encode({username: 'saiaspire', password: 'password'}),
         {'Accept' => MIME_JSON, 'Content-Type' => MIME_JSON}
    assert_response :created
    assert_not_empty json['token']
  end

  test "login with valid information followed by logout" do
    post login_path, json_encode({username: 'saiaspire', password: 'password'}),
         {'Accept' => MIME_JSON, 'Content-Type' => MIME_JSON}
    assert_response :created
    assert_not_empty json['token']
    token = json['token']
    delete logout_path, json_encode({}),
           {'Authorization' => "Bearer #{token}", 'Accept' => MIME_JSON, 'Content-Type' => MIME_JSON}
    assert_response :success
  end
end