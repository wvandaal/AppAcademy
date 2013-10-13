# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  username      :string(255)
#  password      :string(255)
#  session_token :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :password, :session_token, :username

  validates :username, :presence => true
  validates :password, :presence => true, :length => { :minimum => 6 }

  has_many :posts
end
