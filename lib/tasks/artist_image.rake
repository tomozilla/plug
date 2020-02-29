namespace :artist_image do
  desc "Retrieving images for all artists"
  task :update_all => :environment do
    artists = Artist.all
    puts "Enqueuing update of #{artists.size} artists..."
    artists.each do |artist|
      UpdateArtistImage.perform_now(artist.id)
    end
    # rake task will return when all jobs are _enqueued_ (not done).
  end
end
