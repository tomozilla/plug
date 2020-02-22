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
    token = {"Authorization" => "Bearer BQDWaGCJwEgfiDCJ47lLSarSVVngVHBmpy-jw_i7Z2PzrTGpw9ztbMjzmgJJd7PX3VD-zaOWRLbsMLXUQ4qU9Ohp8w7nn5lfrV4u2TBwZe_P1zofed2OGDQUV5tKurRiw0oXiXGd6twT79Rl9-xK0Mbv5hXqeboQAu2wWqS1TSJGsNcG8Hu8kBBDcI5xXljFaaWxaMXkb9Zz6Qx6mlrPU5r2Z93P2eYi800_naQMByrXKCap_c3BntOeK1WVXEspHTDx627GnZw"}
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
