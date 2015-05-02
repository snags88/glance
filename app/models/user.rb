class User < ActiveRecord::Base

  has_many :albums, :foreign_key => 'owner_id'
  has_many :photos

  def self.find_or_create_from_auth_hash(auth_hash)
    User.find_existing_user(auth_hash)|| User.create_with_omnihash(auth_hash)
  end

  private
    def self.create_with_omnihash(auth_hash)
      User.create! do |user|
        user.nickname = auth_hash[:info][:nickname]
        user.name = auth_hash[:info][:name]
        user.image = auth_hash[:info][:image]
        user.provider = auth_hash[:provider]
        user.uid = auth_hash[:uid]
        user.token = auth_hash[:credentials][:token]
      end
    end

    def self.find_existing_user(auth_hash)
      User.where(:uid => auth_hash[:uid], :provider => auth_hash[:provider]).
        where.not(:token => nil).
        first
    end
end
