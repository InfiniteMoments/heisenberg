require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sai)
  end

  test "login with invalid information" do
    post login_path, json_encode({username: @user.username, password: 'wrongpassword'}),
         {'Accept' => MIME_JSON, 'Content-Type' => MIME_JSON}
    assert_response :unauthorized
  end

  test "login with valid information" do
    post login_path, json_encode({username: @user.username, password: 'password'}),
         {'Accept' => MIME_JSON, 'Content-Type' => MIME_JSON}
    assert_response :created
    assert_not_empty json['token']
    assert_equal json['id'], @user.id
    assert_equal json['name'], @user.name
    assert_equal json['email'], @user.email
    assert_equal json['username'], @user.username
  end

  test "login with valid information followed by logout" do
    post login_path, json_encode({username: @user.username, password: 'password'}),
         {'Accept' => MIME_JSON, 'Content-Type' => MIME_JSON}
    assert_response :created
    assert_not_empty json['token']
    assert_equal json['id'], @user.id
    assert_equal json['name'], @user.name
    assert_equal json['email'], @user.email
    assert_equal json['username'], @user.username
    token = json['token']
    delete logout_path, json_encode({}),
           {'Authorization' => "Bearer #{token}", 'Accept' => MIME_JSON, 'Content-Type' => MIME_JSON}
    assert_response :success
  end
end