class Artist < ApplicationRecord
  validates :name, presence: true
  validates :genres, presence: true
  # validates :spotify_id, presence: true
  has_many :artistsTracks
  has_many :tracks, through: :artistsTracks
end
