class Artist < ApplicationRecord
  validates :name, presence: true
  validates :genres, presence: true
  validates :spotify_id, presence: true
  has_many :tracks, through: :artistsTracks
  has_many :artistsTracks
end
