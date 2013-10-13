class User < ActiveRecord::Base
	has_secure_password

  attr_accessible :session_token, :username, :password, :password_confirmation

  validates :username, uniqueness: true

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :photos
  has_many :tags
  has_many :tagged_photos, through: :tags
end
