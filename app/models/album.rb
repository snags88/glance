class Album < ActiveRecord::Base

  belongs_to :owner, class_name: "User"
  has_many :photos

  has_many :album_users
  has_many :contributors, through: :album_users, source: :user

  validates :title, presence: true

  def build_photos
    client = Instagram.client(access_token: self.owner.token)
    client.tag_recent_media(self.title).each do |media|
      if allowed_nicknames.include?(media[:user][:username])
        save_photo
      end
    end
  end

  def build_contributors(usernames)
    client = Instagram.client(access_token: self.owner.token)
    a = usernames.collect do |username|
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
