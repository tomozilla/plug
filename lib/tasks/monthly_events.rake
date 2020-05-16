namespace :monthly_events do
  desc "create monthly events for all the cities"
  task :update_all => :environment do
    WorldCity.where(iso3: "JPN").each do |city|
      CreateCityEvent.perform_now(city)
    end
  end
end
