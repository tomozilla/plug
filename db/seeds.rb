require 'faker'

ArtistsTrack.destroy_all
puts "ArtistsTracks Destroyed"
TracksUser.destroy_all
puts "TracksUsers Destroyed"
UsersEvent.destroy_all
puts "UsersEvents Destroyed"
Artist.destroy_all
puts "Artists Destroyed"
Track.destroy_all
puts "Tracks Destroyed"
Event.destroy_all
puts "Events Destroyed"
User.destroy_all
puts "Users Destroyed"

puts "Start Updating databse"

20.times do 
  new_artist = Artist.create!(
    name: Faker::Music.band,
    genres: Faker::Music.genre,
    image: Faker::LoremFlickr.image,
    spotify_id: Faker::IDNumber.valid
  )

  new_track = Track.create!(
    name: Faker::Music.band,
    album: Faker::Music.album,
    spotify_id: Faker::IDNumber.valid
  )

  new_user = User.create!(
    email: Faker::Internet.email,
    password: "111111",
    genres: Faker::Music.genre,
    spotify_id: Faker::IDNumber.valid
  )

  new_event = Event.create!(
    date: Faker::Date.between(from: 3.days.ago, to: 3.days.from_now),
    venue: Faker::Restaurant.name
  )

  rand_user = User.offset(rand(User.count)).first
  new_event.usersEvents.create!(user: new_user)
  rand_track = Track.offset(rand(Track.count)).first
  new_user.tracksUsers.create!(track: rand_track)
  rand_artist = Artist.offset(rand(Artist.count)).first
  new_track.artistsTracks.create!(artist: rand_artist)
end

puts "Finish Updating databse"