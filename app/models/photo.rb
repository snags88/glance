class Photo < ActiveRecord::Base
  include Tokenable
  belongs_to :album
  belongs_to :user
end
