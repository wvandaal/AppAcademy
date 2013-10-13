class Project < ActiveRecord::Base
  attr_accessible :description, :team_id, :title

  validates :description, :title, :team, presence: true
  validates :title, uniqueness: {scope: :team_id}

  belongs_to :team
  has_many :items
end
