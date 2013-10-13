class Friendship < ActiveRecord::Base
  attr_accessible :cat_id, :human_id
  
  belongs_to :cat
  belongs_to :human
end
