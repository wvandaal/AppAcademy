class Tag < ActiveRecord::Base
  attr_accessible :photo_id, :user_id

  validates :user, :photo, presence: true
  validates :user_id, uniqueness: {scope: :photo_id}

  belongs_to :tagged_user, class_name: "User"
  belongs_to :photo
end
