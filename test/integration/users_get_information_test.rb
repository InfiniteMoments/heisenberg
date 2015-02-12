require 'test_helper'

class UsersGetInformationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sai)
    @other_user = users(:ara)
    log_in_as(@user)
  end

  test "get information of logged in user" do
    get_with_token user_path(@user), {}, {'Accept' => Mime::JSON}
    assert_response :success
    assert_equal json['id'], @user.id
    assert_equal json['username'], @user.username
    assert_equal json['name'], @user.name
    assert_equal json['email'], @user.email
  end

  test "get information of other user" do
    get_with_token user_path(@other_user), {}, {'Accept' => Mime::JSON}
    assert_response :success
    assert_equal json['id'], @other_user.id
    assert_equal json['username'], @other_user.username
    assert_equal json['name'], @other_user.name
    assert_nil json['email']
  end
end