require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com', username: 'exampleuser',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "username should be present" do
    @user.username = "   "
    assert_not @user.valid?
  end

  test "name can't be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email can't be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "username can't be too long" do
    @user.username = "b" * 31
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    dup_user = @user.dup
    dup_user.username = "another_username"
    dup_user.email.upcase!
    @user.save
    assert_not dup_user.valid?
  end

  test "username validation should accept valid usernames" do
    valid_usernames = %w[exampleUser9 exampleuser momentsguy123 HelloMoments moments_best_user
                         this-might-be-awesome_99 1awesome]
    valid_usernames.each do |valid_username|
      @user.username = valid_username
      assert @user.valid?, "#{valid_username.inspect} should be valid"
    end
  end

  test "username validation should reject invalid usernames" do
    invalid_usernames = %w[b0$$ mi*1243 i\am\izzy hh/??AllStars
                           i.am.awesome i@rocks i!!, #yolo]
    invalid_usernames.each do |invalid_username|
      @user.username = invalid_username
      assert_not @user.valid?, "#{invalid_username.inspect} should be invalid"
    end
  end

  test "username should be unique" do
    dup_user = @user.dup
    dup_user.email = "another_email@example.com"
    dup_user.username.upcase!
    @user.save
    assert_not dup_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "username should be saved as lower-case" do
    mixed_case_username = "eXampleUser"
    @user.username = mixed_case_username
    @user.save
    assert_equal mixed_case_username.downcase, @user.reload.username
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
