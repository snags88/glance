module AlbumsHelper

  def chronological_photos(album)
    Photo.where(album_id: album).order(:posted_time)
  end
end
