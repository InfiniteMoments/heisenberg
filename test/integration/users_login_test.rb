require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    post login_path, {username: 'saiaspire', password: 'wrongpassword'}, {'Accept' => Mime::JSON}
    assert_response :unauthorized
  end

  test "login with valid information" do
    post login_path, {username: 'saiaspire', password: 'password'}, {'Accept' => Mime::JSON}
    assert_response :created
    assert_not_empty json['token']
  end

  test "login with valid information followed by logout" do
    post login_path, {username: 'saiaspire', password: 'password'}, {'Accept' => Mime::JSON}
    assert_response :created
    assert_not_empty json['token']
    token = json['token']
    delete logout_path, {}, {'Authorization' => "Bearer #{token}", 'Accept' => Mime::JSON}
    assert_response :success
  end
end