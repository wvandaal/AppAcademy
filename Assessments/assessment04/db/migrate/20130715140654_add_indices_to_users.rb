class AddIndicesToUsers < ActiveRecord::Migration
  def change
		add_index :users, [:username, :password]
		add_index :users, :session_token
  end
end
