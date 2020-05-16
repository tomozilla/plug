require "json"
class CreateCityEvent < ApplicationJob
  queue_as :default

  def perform(city)
    today = Date.today
    event = []
    event <<
    {
      date: today,
      venue: city.city_ascii,
      artist: "#{city.city_ascii}Ranking",
      latitude: city.lat,
      longitude: city.lng,
      genre: "Ranking",
      sub_event: true
    }
    Event.create!(event)
  end

end
