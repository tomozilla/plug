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
    token = {"Authorization" => "Bearer BQAq5Xumotyx2cuB8zlIFKn2CVdTg7UrnQHteddUhe1mLUVTzlK6Pus-JlZXjOcPEa03r6DIRAaOiMVoZTB1ew4BSLIJk3KeubeKLdPbATND8xUJhMS105MfLIX2OvRO_EbDUlmE3VJLesA"}
    artist_search = "https://api.spotify.com/v1/search?q=#{artist}&type=artist"
    artist_search_serialized = open(artist_search, token).read
    search_result = JSON.parse(artist_search_serialized)
    artist_id = search_result["artists"]["items"].first["id"]
    url = "https://api.spotify.com/v1/artists?ids=#{artist_id}"
    data_serialized = open(url, token).read
    data_result = JSON.parse(data_serialized)
    artist_image_url = data_result["artists"].first["images"].first["url"]
    file = URI.open(artist_image_url)
    photo.attach(io: file, filename: "#{artist}.png", content_type: 'image/png')
  end
end
