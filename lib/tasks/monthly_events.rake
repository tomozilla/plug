namespace :monthly_events do
  desc "create monthly events for all the cities"
  task :update_all => :environment do
    WorldCity.destroy_all
    CSV.foreach(Rails.root.join('worldcities.csv'), headers: true) do |row|
      if %w[USA JPN KOR SGR AUS].include?(row[6])
        WorldCity.create!(
          city: row[0],
          city_ascii: row[1],
          lat: row[2],
          lng: row[3],
          country: row[4],
          iso2: row[5],
          iso3: row[6],
          admin_name: row[7],
          capital: row[8],
          population: row[9],
          city_id: row[10]
        )
      end
    end
    WorldCity.where(iso3: "USA").limit(200).each do |city|
      CreateCityEvent.perform_now(city)
    end
    WorldCity.where(iso3: %w[JPN KOR SGR AUS]).each do |city|
      CreateCityEvent.perform_now(city)
    end
    WorldCity.destroy_all
  end
end
