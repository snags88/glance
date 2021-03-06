class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :name
      t.text :image
      t.string :provider
      t.string :uid
      t.string :token

      t.timestamps null: false
    end
  end
end
