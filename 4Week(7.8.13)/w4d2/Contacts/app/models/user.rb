class User < ActiveRecord::Base
  attr_accessible :email, :name, :phone, :address

  has_many :listings, dependent: :destroy
  has_many :contacts, through: :listings
  has_many :inverse_listings, class_name: "Listing", foreign_key: "contact_id"
  has_many :inverse_contacts, through: :inverse_listings, source: :user


end
