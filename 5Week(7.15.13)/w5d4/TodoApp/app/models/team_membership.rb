class TeamMembership < ActiveRecord::Base
  attr_accessible :team_id, :user_id

  validates :user, :team, presence: true
  validates :user_id, uniqueness: {scope: :team_id}

  belongs_to :team
  belongs_to :user
end
