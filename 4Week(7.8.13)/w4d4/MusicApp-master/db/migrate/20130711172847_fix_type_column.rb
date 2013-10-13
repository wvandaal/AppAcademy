class FixTypeColumn < ActiveRecord::Migration
  def change
    rename_column :albums, :type, :album_type
    rename_column :tracks, :type, :track_type
  end
end
