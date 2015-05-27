module AlbumsHelper

  def ordered_photos(album)
    Photo.where(album_id: album).order(:order)
  end

  def show_edit_menu(album)
    if album.owner == current_user
      render 'albums/sidebar/edit', album: album
    end
  end
end
