class Item < ActiveRecord::Base
  attr_accessible :completed, :description, :project_id, :title

  validates :description, :project, :title, presence: true
  validates :completed, inclusion: { in: [true, false] }

  belongs_to :project
end
