class Track < ApplicationRecord
  has_many :tracks_users
  has_many :artists_tracks
  has_many :artists, through: :artists_tracks
  has_many :events, through: :tracks_users
  validates :name, presence: true
  validates :album, presence: true
  validates :spotify_id, presence: true

  def favorited_from
    return Event.first
  end
end
