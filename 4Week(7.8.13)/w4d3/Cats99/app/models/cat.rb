class Cat < ActiveRecord::Base
  COLORS = %w(orange black white gray yellow brown)

  attr_accessible :birth_date, :color, :name, :sex, :user_id

  validates :name, :sex, :color, :birth_date, :user_id, presence: true
  validates :user_id, inclusion: {in: User.pluck(:id) }
  validates :color, inclusion: {in: COLORS}
  validates :sex, inclusion: {in: %w(male female)}
  validate :birth_date_in_the_past

  has_many :rental_requests, class_name: "CatRentalRequest", dependent: :destroy
  belongs_to :user

  def age
    (Date.today - birth_date).to_i / 365
  end

  def birth_date_in_the_past
    if !birth_date.blank? && birth_date > Date.today
      errors.add(:birth_date, "can't be in the past")
    end
  end

  def self.sexes
    %w(male female)
  end

  def self.colors
    COLORS
  end
end
