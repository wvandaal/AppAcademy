class AddIndicesToDatesAndIdInCatRentalRequests < ActiveRecord::Migration
  def change
	add_index :cat_rental_requests, :cat_id
	add_index :cat_rental_requests, :begin_date
	add_index :cat_rental_requests, :end_date
  end
end
