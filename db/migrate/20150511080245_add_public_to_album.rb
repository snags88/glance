class AddPublicToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :public, :boolean
  end
end
