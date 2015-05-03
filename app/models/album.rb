class Album < ActiveRecord::Base

  belongs_to :owner, class_name: "User"
  has_many :photos

  validates :title, presence: true

  def build_contributors(contributor_params)
    # {"names"=>["a;sldkfj", "oaisdjf", "209fjas"]}

  end

  def self.build_with_owner(album_params, user)
    Album.new(album_params, :owner => user)
  end
end
