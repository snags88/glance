class CreateAlbumUsers < ActiveRecord::Migration
  def change
    create_table :album_users do |t|
      t.references :album, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :album_users, :albums
    add_foreign_key :album_users, :users
  end
end
