require "json"
class CreateCityEvent < ApplicationJob
  queue_as :default

  def perform(city)
    today = Date.today
    event = []
    event <<
      {
        date: today,
        venue: "Top 10 songs in #{city.city_ascii} for #{Date.today.strftime("%B")}",
        artist: city.city_ascii,
        latitude: city.lat,
        longitude: city.lng,
        genre: "Ranking",
        sub_event: true
      }
    new_event = Event.create!(event[0])
    2.times do
      UsersEvent.create!(
        user: User.where(email: 'tomohiromitani@hotmail.com').first,
        event: new_event
      )
    end
    2.times do
      TracksUser.create!(
        event: new_event,
        user: User.where(email: 'tomohiromitani@hotmail.com').first,
        track: Track.all.sample
      )
    end
  end
end
