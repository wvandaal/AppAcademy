class AllowNullForPubDateInAlbums < ActiveRecord::Migration
  def change
    change_column :albums, :pub_date, :date, :null => true
  end
end
