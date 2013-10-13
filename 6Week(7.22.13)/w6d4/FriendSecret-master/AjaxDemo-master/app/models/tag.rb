class Tag < ActiveRecord::Base
  attr_accessible :name

  has_many :secret_taggings

  validates_presence_of :name
  validates_uniqueness_of :name
end
