class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.boolean :completed
      t.integer :project_id

      t.timestamps
    end
  end
end
