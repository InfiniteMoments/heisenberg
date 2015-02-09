class User < ActiveRecord::Base
  before_save :downcase_email, :downcase_username
  validates :name, presence: true, length: {maximum: 50}

  VALID_USERNAME_REGEX = /\A[\w\-]+\Z/
  validates :username, presence: true, length: {maximum: 30},
            format: {with: VALID_USERNAME_REGEX}, uniqueness: {case_sensitive: false}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  validates :password, length: {minimum: 6}
  has_secure_password

  def generate_auth_token
    AuthHelper.encode({user_id: self.id})
  end

  private

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  # Converts username to all lower-case.
  def downcase_username
    self.username = username.downcase
  end
end
