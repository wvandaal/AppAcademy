class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
      t.text :biography
      t.integer :color_id
      t.string :gender
      t.date :birthday

      t.timestamps
    end
  end
end
