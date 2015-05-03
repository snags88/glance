class Album < ActiveRecord::Base

  belongs_to :owner, class_name: "User"
  has_many :photos

  has_many :album_users
  has_many :contributors, through: :album_users, source: :user

  validates :title, presence: true

  def build_photos
    client = Instagram.client(access_token: self.owner.token)
    client.tag_recent_media(self.title).each do |media|
      if allowed_nicknames.include?(media[:user][:username]) && media[:type] == "image"
        # find if photo exists and is already part of album
        Photo.where(:insta_id => media[:id], :album_id => self)
        # create if it does not
        Photo.new.tap do |photo|
          photo.caption = media[:caption][:text]
          photo.media_url = media[:images][:standard_resolution][:url]
          photo.type = media[:type]
          photo.insta_id = media[:id]
          photo.latitude = media[:location][:latitude]
          photo.longitude = media[:location][:longitude]
          photo.location_name = media[:location][:name]
          photo.posted_time = Time.at(media[:created_time].to_i).utc
          photo.album = self
          photo.user = User.find_by(:uid => media[:user][:id])
        end

      end
    end
  end

  def build_contributors(usernames)
    client = Instagram.client(access_token: self.owner.token)
    usernames.collect do |username|
      if username != ""
        user = client.user_search(username).first
        if user
          contributor = User.find_or_create_contributor(user)
          self.contributors << contributor
          contributor
        end
      end
    end.compact
  end

  def allowed_nicknames
    (contributors + [owner]).collect(&:nickname).uniq
  end

  def self.build_with_owner(album_params, user)
    album = Album.new(album_params)
    album.owner = user
    album
  end
end
