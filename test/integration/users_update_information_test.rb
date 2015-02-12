require 'test_helper'

class UsersUpdateInformationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sai)
    log_in_as(@user)
  end

  test "update user details with invalid information" do
    patch_with_token user_path(@user), {name: '', email: '9829example.com'}, {'Accept' => Mime::JSON}
    assert_response :unprocessable_entity
  end

  test "update user details with valid information" do
    name = 'New Name'
    email = 'new@example.com'
    patch_with_token user_path(@user), {name: name, email: email}, {'Accept' => Mime::JSON}
    assert_response :success
    assert_equal json['name'], name
    assert_equal json['email'], email
    assert_equal json['id'], @user.id
    assert_equal json['username'], @user.username
  end

  test "update user with invalid password" do
    password = 'a'
    patch_with_token user_path(@user), {password: password}, {'Accept' => Mime::JSON}
    assert_response :unprocessable_entity
  end

  test "update user with valid password" do
    password = 'newpassword'
    patch_with_token user_path(@user), {password: password}, {'Accept' => Mime::JSON}
    assert_response :success
    assert_equal json['name'], @user.name
    assert_equal json['email'], @user.email
    assert_equal json['id'], @user.id
    assert_equal json['username'], @user.username
  end
end