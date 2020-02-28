class Artist < ApplicationRecord
  validates :name, presence: true
  # validates :genres, presence: true
  validates :spotify_id, presence: true
  has_many :artists_tracks
  has_many :tracks, through: :artists_tracks
  has_one_attached :photo
  # after_create :retrieve_artist_image_genre
  after_commit :async_update

  private

  def async_update
    UpdateArtistImage.perform_later
  end

  # def retrieve_artist_image_genre
  #   require "open-uri"
  #   require "json"
  #   require "rspotify"
  #   RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
  #   artist_info = RSpotify:: Artist.search(name)
  #   artist_image_url = artist_info.first.images.first["url"]
  #   file = URI.open(artist_image_url)
  #   photo.attach(io: file, filename: "#{name}.png", content_type: 'image/png')
  #   artist_genres = artist_info.first.genres.first
  #   self.genres = artist_genres
  # end
end
