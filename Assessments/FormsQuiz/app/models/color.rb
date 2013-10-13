class Color < ActiveRecord::Base
  attr_accessible :name
  
  validate :name, :presence => true
end
