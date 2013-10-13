class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.integer :contact_id
      t.boolean :favorite, default: false

      t.timestamps
    end
  end
end
