class User < ActiveRecord::Base
  attr_accessible :password, :session_token, :username

  validates :password, :username, presence: true
  validate :password_length

  has_many :posts

  private
  def password_length
    if password.length < 6
      errors[:password] << "password too short"
    end
  end
end
