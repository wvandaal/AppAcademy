class Listing < ActiveRecord::Base
  attr_accessible :contact_id, :favorite, :user_id

  belongs_to :user
  belongs_to :contact, :class_name => "User"
end
