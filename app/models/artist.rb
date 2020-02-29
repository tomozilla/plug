class Artist < ApplicationRecord
  validates :name, presence: true
  # validates :genres, presence: true
  validates :spotify_id, presence: true
  has_many :artists_tracks
  has_many :tracks, through: :artists_tracks
  has_one_attached :photo
end
