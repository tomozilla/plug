namespace :artist_image do
  desc "Retrieving images for all artists"
  task :update_all => :environment do
    puts "Starting Rake Task"
    AddPermission.perform_now()
    # rake task will return when all jobs are _enqueued_ (not done).
  end
end
