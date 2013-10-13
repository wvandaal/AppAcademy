class AddBodyToSecret < ActiveRecord::Migration
  def change
    add_column :secrets, :body, :text
  end
end
