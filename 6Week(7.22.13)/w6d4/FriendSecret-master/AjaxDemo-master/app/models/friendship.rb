class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :user_id

  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :friend, :user, presence: true
  validates :friend_id, uniqueness: {scope: :user_id}
end
