class Band < ActiveRecord::Base
  attr_accessible :name

  has_many :albums, :dependent => :destroy
  has_many :tracks, :through => :albums

  validates :name, :presence => true
  validates :name, :uniqueness => true

  default_scope order('name')
end