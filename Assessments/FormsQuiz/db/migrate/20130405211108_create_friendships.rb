class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :cat_id
      t.integer :human_id

      t.timestamps
    end
  end
end
