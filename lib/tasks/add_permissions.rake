namespace :add_permissions do
  desc "Adding permission to review apps"
  task :update_all => :environment do
    puts "Starting Rake Task"
    AddPermission.perform_now()
    # rake task will return when all jobs are _enqueued_ (not done).
  end
end
