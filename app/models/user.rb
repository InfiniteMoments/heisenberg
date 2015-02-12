class User < ActiveRecord::Base
  before_save :downcase_email, :downcase_username
  validates :name, presence: true, length: {maximum: 50}

  VALID_USERNAME_REGEX = /\A[\w\-]+\Z/
  validates :username, presence: true, length: {maximum: 30},
            format: {with: VALID_USERNAME_REGEX}, uniqueness: {case_sensitive: false}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  # allow nil password only for update not for create
  # has_secure_password checks for non nil password on create
  validates :password, length: {minimum: 6}, allow_nil: true
  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
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
