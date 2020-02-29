require "open-uri"
require "json"
require "rspotify"
class UpdateArtistImage < ApplicationJob
  queue_as :default

  def perform(artist_id)
    puts "running"
    artist = Artist.find(artist_id)
    # p artist
    unless artist.photo.attached?
      RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
      artist_info = RSpotify:: Artist.search(artist.name)
      artist_image_url = artist_info.first.images.first["url"]
      file = URI.open(artist_image_url)
      # p file
        if file.meta["content-type"].split("/").last == 'jpeg'
          extention = 'jpg'
        else
          extention = file.meta["content-type"].split("/").last
        end
      # p extention
      begin
        artist.photo.attach(io: file, filename: "#{artist.name}.#{extention}", content_type: file.meta["content-type"])
      rescue
        puts "Using a default photo"
        sub_file = File.open(File.join(Rails.root,'app/assets/images/plug_logo.png'))
        artist.photo.attach(io: sub_file, filename: "#{artist.name}.png", content_type: "image/png")
      end
      puts "Artist image for #{artist.name} uploaded in Cloudinary..."
      artist.genres = artist_info.first.genres.first
      puts "Artist genre for #{artist.name} added"
      puts "Done!"
    end
  end
end
