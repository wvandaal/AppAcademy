class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :contact_id

      t.timestamps
    end
    add_index :favorites, :user_id
    add_index :favorites, :contact_id
    add_index :favorites, [:user_id, :contact_id], unique: true
  end
end
