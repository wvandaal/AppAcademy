class Note < ActiveRecord::Base
  attr_accessible :body, :track_id

  belongs_to :user
  belongs_to :track

  validates :body, :user, :track, :presence => true
end
