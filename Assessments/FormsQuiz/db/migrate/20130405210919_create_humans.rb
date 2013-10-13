class CreateHumans < ActiveRecord::Migration
  def change
    create_table :humans do |t|
      t.string :name

      t.timestamps
    end
  end
end
