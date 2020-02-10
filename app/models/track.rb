class Track < ApplicationRecord
  has_many :artists through :artistsTrack
end
