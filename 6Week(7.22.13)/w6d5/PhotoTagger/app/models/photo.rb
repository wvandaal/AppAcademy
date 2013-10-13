class Photo < ActiveRecord::Base
  attr_accessible :url, :user_id, :title

  validates :url, :user, :title, presence: true
  validates :url, uniqueness: {scope: :user_id}

  belongs_to :user
  has_many :tags
  has_many :tagged_users, through: :tags
end
