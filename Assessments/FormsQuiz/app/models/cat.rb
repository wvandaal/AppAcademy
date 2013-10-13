class Cat < ActiveRecord::Base
  attr_accessible :biography, :birthday, :color_id, :gender, :name, :human_ids
  
  belongs_to :color
  has_many :friendships
  has_many :humans, :through => :friendships
  
  validate :biography, :birthday, :gender, :name, :presence => true
  validate :gender, :inclusion => {:in => %w(M F)}
end
