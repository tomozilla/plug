namespace :delete_monthly_events do
  desc "delete monthly sub events"
  task :update_all => :environment do
    Event.where(sub_event: true).each do |event|
      event.date = nil
      event.save
    end
  end
end
