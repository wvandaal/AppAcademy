class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :password, :null => false
      t.string :session_token, :null => true
      t.string :activation_token, :null => true
      t.boolean :admin, :null => false, :default => false

      t.timestamps
    end
    add_index :users, :email, :unique => true
    add_index :users, :session_token
    add_index :users, :activation_token
  end
end
