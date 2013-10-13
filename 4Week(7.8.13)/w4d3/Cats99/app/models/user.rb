class User < ActiveRecord::Base
  attr_accessible :password, :session_token, :username

  validates :username, :password, presence: true
  validates :username, uniqueness: true

  has_many :cats

  def self.authenticate(params = {})
    User.find_by_username_and_password(params[:username], params[:password])
  end

end
