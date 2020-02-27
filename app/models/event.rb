class Event < ApplicationRecord
  has_many :users_events
  has_many :users, through: :users_events
  has_many :tracks_users
  has_many :favorited_tracks, through: :tracks_users, source: :track
  validates :venue, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo
  after_create :retrieve_artist_image
  # , if: :will_save_change_to_address?
  def retrieve_artist_image
    require "open-uri"
    require "json"
    require "rspotify"
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
    artist_info = RSpotify::Artist.search(artist)
    artist_image_url = artist_info.first.images.first["url"]
    file = URI.open(artist_image_url)
    photo.attach(io: file, filename: "#{artist}.png", content_type: 'image/png')
  end
end
