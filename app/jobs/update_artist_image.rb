class UpdateArtistImage < ApplicationJob
  queue_as :default

  def perform
    require "open-uri"
    require "json"
    require "rspotify"
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
    artist_info = RSpotify:: Artist.search(name)
    artist_image_url = artist_info.first.images.first["url"]
    file = URI.open(artist_image_url)
    photo.attach(io: file, filename: "#{name}.png", content_type: 'image/png')
    puts "Artist image for #{name} uploaded in Cloudinary..."
    artist_genres = artist_info.first.genres.first
    self.genres = artist_genres
    puts "Artist genre for #{name} added"
    puts "Done!"
  end
end
