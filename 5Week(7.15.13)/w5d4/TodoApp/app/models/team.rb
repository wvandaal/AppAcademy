class Team < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :projects
  has_many :team_memberships, dependent: :destroy
  has_many :users, through: :team_memberships
end
