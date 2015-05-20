class Album < ActiveRecord::Base
  include Tokenable
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :owner, class_name: "User"
  has_many :photos, dependent: :destroy

  has_many :album_users, dependent: :destroy
  has_many :contributors, through: :album_users, source: :user

  validates :title, presence: true
  validates :public, inclusion: [true, false]

  def build_photos
    client = Instagram.client(access_token: self.owner.token)
    # Need to add pagination from result
    client.tag_recent_media(self.title, count: 33).each do |media|
      if allowed_nicknames.include?(media[:user][:username]) && media[:type] == "image"
        if Photo.where(:insta_id => media[:id], :album_id => self).empty?
        # create if it does not
          Photo.create! do |photo|
            photo.caption = media[:caption][:text]
            photo.media_url = media[:images][:standard_resolution][:url]
            photo.kind = media[:type]
            photo.insta_id = media[:id]
            if media[:location]
              photo.latitude = media[:location][:latitude]
              photo.longitude = media[:location][:longitude]
              photo.location_name = media[:location][:name]
            end
            photo.posted_time = Time.at(media[:created_time].to_i).utc
            photo.album = self
            photo.user = User.find_by(:uid => media[:user][:id])
            photo.order = Photo.where(album: self).count + 1
          end
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

  def remove_contributors(usernames)
    AlbumUser.joins(:user).where(:album_id => self, :users => {:nickname => usernames}).destroy_all
    Photo.joins(:user).where(:album_id => self, :users => {:nickname => usernames}).destroy_all
  end

  def allowed_nicknames
    (contributors + [owner]).collect(&:nickname).uniq
  end

  def self.build_with_owner(album_params, user)
    album = Album.new(album_params)
    album.owner = user
    album
  end

  def update_contributors(usernames)
    contributors = self.contributors.pluck(:nickname)
    added = []
    removed = contributors.dup
    usernames.each do |username|
      contributors.include?(username) ? removed.delete(username) : added << username
    end
    build_contributors(added)
    remove_contributors(removed)
  end

  def update_album(album_params)
    Photo.where(:album_id => self).destroy_all if self.title != album_params[:title]
    self.update(album_params)
  end
end
