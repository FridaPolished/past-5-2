class User < ApplicationRecord
  validates :username, :session_token, :email, :password_digest, presence: true
  validates :session_token, :username, :email, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  attr_reader :password

  after_initialize :ensure_session_token

   has_many :subs,
  foreign_key: :moderator_id,
  class_name: :Sub

  has_many :posts,
  foreign_key: :author_id,
  class_name: :Post

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    return nil unless @user
    @user.is_password?(password) ? @user : nil
  end

  def is_password?(password)
    BCrypt:Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||=SecureRandom.urlsafe_base64
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

end
