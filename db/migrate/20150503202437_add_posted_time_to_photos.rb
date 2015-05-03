class AddPostedTimeToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :posted_time, :datetime
  end
end
