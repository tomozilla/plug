class Artist < ApplicationRecord
  validates :name, presence: true
  validates :genres, presence: true
  validates :image, presence: true
  validates :spotify_artist_id, presence: true
  has_many :tracks, through: :artistsTracks
end
