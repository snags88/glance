class ChangeTypeToKindOnPhotos < ActiveRecord::Migration
  def change
    rename_column :photos, :type, :kind
  end
end
