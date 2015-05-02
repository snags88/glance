class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :caption
      t.string :media_url
      t.string :type
      t.string :insta_id
      t.float :latitude
      t.float :longitude
      t.string :location_name
      t.references :album, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :photos, :albums
    add_foreign_key :photos, :users
  end
end
