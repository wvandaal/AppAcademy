class Album < ActiveRecord::Base
  attr_accessible :pub_date, :title, :album_type

  belongs_to :band
  has_many :tracks, :dependent => :destroy

  validates :band, :title, :album_type, :presence => true
  validates :title, :uniqueness => { :scope => :band_id }
  validates :album_type, :inclusion => {:in => ALBUM_TYPES}

end
