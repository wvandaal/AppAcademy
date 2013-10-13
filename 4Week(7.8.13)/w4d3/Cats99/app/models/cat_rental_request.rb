class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(undecided approved denied)

  attr_accessible :begin_date, :cat_id, :end_date, :status

  validates :begin_date, :end_date, :cat_id, :status, presence: true
  validate :not_rented, :valid_dates
  validates :status, inclusion: {in: STATUSES}

  belongs_to :cat

  def valid_dates
    errors.add(:begin_date, "invalid rental period") if begin_date > end_date
  end

  def not_rented
    unless CatRentalRequest.where("cat_id = ? AND status = ? AND
                            NOT(end_date < ? OR begin_date > ?)",
                            cat_id, "approved", begin_date, end_date).empty?
      errors.add(:cat_id, "Overlapping rental")
    end
  end

  def approve
    self.update_attributes(status: "approved")
    conflicting = CatRentalRequest.where("cat_id = ? AND status = ? AND
                            NOT(end_date < ? OR begin_date > ?)",
                            cat_id, "undecided", begin_date, end_date)
    p conflicting
    conflicting.each { |request| request.update_attribute(:status, "denied") }
  end

end
