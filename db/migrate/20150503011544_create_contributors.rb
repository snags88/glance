class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.references :album, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :contributors, :albums
    add_foreign_key :contributors, :users
  end
end
