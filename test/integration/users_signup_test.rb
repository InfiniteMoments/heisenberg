require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "signup with invalid information" do
    post users_path, json_encode({name: '', username: '&!(dd', email: '1908example.com', password: 'goo'}),
         {'Accept' => MIME_JSON, 'Content-Type' => MIME_JSON}
    assert_response :unprocessable_entity
  end

  test "signup with valid information" do
    name = 'Test User'
    email = 'test@example.com'
    username = 'testuser'
    assert_difference 'User.count', 1 do
      post users_path, json_encode({name: name, username: username, email: email, password: 'foobar'}),
           {'Accept' => MIME_JSON, 'Content-Type' => MIME_JSON}
    end
    assert_response :created
    assert_not_empty json['token']
    assert_equal json['name'], name
    assert_equal json['email'], email
    assert_equal json['username'], username
  end
end