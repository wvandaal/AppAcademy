class Human < ActiveRecord::Base
  attr_accessible :name
  
  has_many :friendships
  has_many :cats, :through => :friendships
  
  validate :name, :presence => true
end
