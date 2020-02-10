class Track < ApplicationRecord
  belong_to :tracksUser
  has_many :artists through :artistsTrack
end
