# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#

class Tag < ActiveRecord::Base
  attr_accessible :name, :post_id

  belongs_to :post
end
