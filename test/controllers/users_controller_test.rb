require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:sai)
    @other_user = users(:ara)
  end

  test "should return unauthorized for show when not logged in" do
    get :show, {id: @user.id}
    assert_response :unauthorized
  end

  test "should return unauthorized for update when not logged in" do
    patch :update, {id: @user.id}
    assert_response :unauthorized
  end

  test "should return forbidden for update when logged in as another user" do
    log_in_as(@other_user)
    patch :update, {id: @user.id}
    assert_response :forbidden
  end
end
