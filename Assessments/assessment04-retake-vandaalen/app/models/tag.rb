class Tag < ActiveRecord::Base
	attr_accessible :name, :post_id

	validates :name, :post, presence: true

	belongs_to :post
end