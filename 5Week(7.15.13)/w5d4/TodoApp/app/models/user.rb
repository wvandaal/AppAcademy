class User < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships
end
