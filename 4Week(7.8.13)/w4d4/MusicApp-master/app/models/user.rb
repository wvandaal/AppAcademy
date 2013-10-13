class User < ActiveRecord::Base
  attr_accessible :email, :password

  has_many :notes, :dependent => :destroy
  has_many :commented_tracks, :through => :notes, class_name: "Track"

  validates :email, :password, :presence => true
  validates :email, :uniqueness => true

  before_validation :set_activation_token, on: :create

  private
  def set_activation_token
    token = SecureRandom.urlsafe_base64
    while User.pluck(:activation_token).include?(token)
      token = SecureRandom.urlsafe_base64
    end
    self.activation_token = token
  end
end
