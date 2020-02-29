class Artist < ApplicationRecord
  validates :name, presence: true
  # validates :genres, presence: true
  validates :spotify_id, presence: true
  has_many :artists_tracks
  has_many :tracks, through: :artists_tracks
  has_one_attached :photo
  # after_create :retrieve_artist_image_genre
  # after_commit :async_update

  # private

  # def async_update
    # UpdateArtistImage.perform_later
  # end
end
