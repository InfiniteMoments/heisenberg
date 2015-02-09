class User < ActiveRecord::Base
  before_save :downcase_email
  validates :name, presence: true, length: {maximum: 50}
  validates :username, presence: true, length: {maximum: 20}, uniqueness: {case_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}
  has_secure_password

  private

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end
end
