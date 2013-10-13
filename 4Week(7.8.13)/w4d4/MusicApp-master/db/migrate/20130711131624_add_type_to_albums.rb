class AddTypeToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :type, :string, :null => false, :default => "studio"
  end
end
