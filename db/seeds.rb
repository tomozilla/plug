require 'faker'

ArtistsTrack.destroy_all
puts "Artists_tracks Destroyed"
TracksUser.destroy_all
puts "TracksUsers Destroyed"
UsersEvent.destroy_all
puts "Users_events Destroyed"
Artist.destroy_all
puts "Artists Destroyed"
Track.destroy_all
puts "Tracks Destroyed"
Event.destroy_all
puts "Events Destroyed"
User.destroy_all
puts "Users Destroyed"

puts "Start Updating databse"
location_choice = ["Impact Hub", "Lawson", "Maruetsu"]
address_choice = ["Tokyo, Meguro City, Meguro, 2−11−3", "3 Chome-9-1 Meguro, Meguro City, Tokyo", "2 Chome-21-23 Shimomeguro, Meguro City, Tokyo"]

rand_number = rand(0..2)

new_event = Event.create!(
  date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now),
  address: address_choice[rand_number],
  venue: location_choice[rand_number]
)

# 20.times do
#   new_artist = Artist.create!(
#     name: Faker::Music.band,
#     genres: Faker::Music.genre,
#     image: Faker::LoremFlickr.image,
#     spotify_id: Faker::Internet.password
#   )

#   new_track = Track.create!(
#     name: Faker::Music.band,
#     album: Faker::Music.album,
#     spotify_id: Faker::Internet.password
#   )

#   new_user = User.create!(
#     email: Faker::Internet.email,
#     password: "111111",
#     genres: Faker::Music.genre,
#     spotify_id: Faker::Internet.password
#   )

#   new_event = Event.create!(
#     date: Faker::Date.between(from: 3.days.ago, to: 3.days.from_now),
#     venue: Faker::Restaurant.name
#   )

#   rand_user = User.offset(rand(User.count)).first
#   new_event.users_events.create!(user: new_user)
#   rand_track = Track.offset(rand(Track.count)).first
#   TracksUser.create!(user: new_user, track: rand_track, event: new_event)
#   rand_artist = Artist.offset(rand(Artist.count)).first
#   new_track.artists_tracks.create!(artist: rand_artist)
# end

#   new_user = User.create!(
#     email: "paula@plug.com",
#     password: "111111",
#     genres: Faker::Music.genre,
#     spotify_id: Faker::Internet.password
#   )

# 20.times do
#   new_artist = Artist.create!(
#     name: Faker::Music.band,
#     genres: Faker::Music.genre,
#     image: Faker::LoremFlickr.image,
#     spotify_id: Faker::Internet.password
#   )

#   new_track = Track.create!(
#     name: Faker::Music.band,
#     album: Faker::Music.album,
#     spotify_id: Faker::Internet.password
#   )



#   new_event = Event.create!(
#     date: Faker::Date.between(from: 3.days.ago, to: 3.days.from_now),
#     venue: Faker::Restaurant.name
#   )

#   rand_user = User.offset(rand(User.count)).first
#   new_event.users_events.create!(user: new_user)
#   rand_track = Track.offset(rand(Track.count)).first
#   TracksUser.create!(user: new_user, track: rand_track, event: new_event)
#   rand_artist = Artist.offset(rand(Artist.count)).first
#   new_track.artists_tracks.create!(artist: rand_artist)
# end

# puts "Finish Updating database"
