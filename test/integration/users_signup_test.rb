require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "signup with invalid information" do
    post users_path, {name: '', username: '&!(dd', email: '1908example.com', password: 'goo'}, {'Accept' => Mime::JSON}
    assert_response :unprocessable_entity
  end

  test "signup with valid information" do
    assert_difference 'User.count', 1 do
      post users_path, {name: 'Test User', username: 'testuser', email: 'test@example.com', password: 'foobar'}, {'Accept' => Mime::JSON}
    end
    assert_response :created
    assert_not_empty json['token']
  end
end