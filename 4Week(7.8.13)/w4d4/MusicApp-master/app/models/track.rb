class Track < ActiveRecord::Base
  attr_accessible :lyrics, :title, :track_type

  belongs_to :album
  has_one :band, :through => :album
  has_many :notes, :dependent => :destroy

  validates :album, :title, :track_type, :presence => true
  validates :track_type, :inclusion => {:in => TRACK_TYPES}
  validates :title, :uniqueness => { :scope => :album_id }
end
