require "json"
class CreateCityEvent < ApplicationJob
  queue_as :default

  def perform(city)
    today = Date.today
    event = []
    event <<
    {
      date: today,
      venue: "Top 20 songs in #{city.city_ascii} for #{Date.today.strftime("%B")}",
      artist: city.city_ascii,
      latitude: city.lat,
      longitude: city.lng,
      genre: "Ranking",
      sub_event: true
    }
    Event.create!(event)
  end

end
