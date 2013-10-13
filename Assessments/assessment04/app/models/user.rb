class User < ActiveRecord::Base
  attr_accessible :password, :username, :session_token

  validates :username, :password, presence: true
  validates :username, :password, length: {minimum: 6}
  validates :username, uniqueness: true

  has_many :posts
end
