class Track < ApplicationRecord
  has_many :artistsTracks
  has_many :artists, through: :artistsTrack
end
