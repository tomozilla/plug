class Artist < ApplicationRecord
  has_many :artistsTracks
  has_many :tracks, through: :artistsTrack
end
