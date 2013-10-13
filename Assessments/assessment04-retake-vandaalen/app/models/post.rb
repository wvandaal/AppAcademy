class Post < ActiveRecord::Base
	attr_accessible :title, :body, :user_id

	validates :title, :body, :user, presence: true

	belongs_to :user
	has_many :tags
end