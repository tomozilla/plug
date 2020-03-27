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

users = [
  {
    email: ENV['USER1_EMAIL'],
    password: "111111",
    refresh_token: ENV['USER1_REFRESH_TOKEN'],
    spotify_id: ENV['USER1_SPOTIFY_ID'],
    updated_at: "2020-02-20 11:28:40"
  }
]

users.each do |user|
  createdUser = User.create(user)
  RefreshTokenService.refresh_token(createdUser)
  FetchTracksService.downloadTracks(createdUser)
end

puts "1"

10.times do
  User.create!(
    email: Faker::Internet.email,
    spotify_id: Faker::Internet.username,
    password: "111111")
end

puts "2"

events = [
  {
    date: Faker::Date.between(from: 0.days.from_now, to: 0.days.from_now),
    venue: "UNIT",
    # address: "Tokyo, Shibuya City, Ebisunishi, 1 Chome−34−17",
    artist: "Bob Moses",
    latitude: 35.634718,
    longitude: 139.708336,
    genre: "Dance/Electronic"
  },
    {
    date: Faker::Date.between(from: 0.days.from_now, to: 0.days.from_now),
    venue: "LIQUIDROOM",
    # address: "Tokyo, Shibuya City, Higashi, 3 Chome-16-6",
    artist: "Carl Cox",
    latitude: 35.648224,
    longitude: 139.702427,
    genre: "Dance/Electronic"
  },
  {
    date: Faker::Date.between(from: 0.days.from_now, to: 0.days.from_now),
    venue: "The Room",
    # address: "Tokyo, Shibuya City, Sakuragaokacho, 15−19",
    artist: "Emotional Oranges",
    latitude: 35.656655,
    longitude: 139.701640,
    genre: "R&B/pop"
  },
  {
    date: Faker::Date.between(from: 0.days.from_now, to: 0.days.from_now),
    venue: "SEL OCTAGON TOKYO",
    # address: "Tokyo, Minato City, Roppongi, 7 Chome−8−6",
    artist: "FDVM",
    latitude: 35.665174,
    longitude: 139.729830,
    genre: "French House"
  },
  {
    date: Faker::Date.between(from: 0.days.from_now, to: 0.days.from_now),
    venue: "Billboard Live Tokyo",
    # address: "Tokyo, Minato City, Akasaka, 9 Chome−7−4",
    artist: "GoldLink",
    latitude: 35.666687,
    longitude: 139.730918,
    genre: "House"
  },
  {
    date: Faker::Date.between(from: 1.days.from_now, to: 7.days.from_now),
    venue: "ageHa",
    # address: "Tokyo, Shibuya City, Ebisunishi, 1 Chome−34−17",
    artist: "Loud Luxury",
    latitude: 35.642927,
    longitude: 139.825334,
    genre: "Dance/Electronic"
  },
  {
    date: Faker::Date.between(from: 14.days.ago, to: 6.days.ago),
    venue: "LIQUIDROOM",
    # address: "Tokyo, Shibuya City, Higashi, 3 Chome-16-6",
    artist: "FKJ",
    latitude: 35.648224,
    longitude: 139.702427,
    genre: "French House"
  },
  {
    date: Faker::Date.between(from: 1.days.from_now, to: 7.days.from_now),
    venue: "The Room",
    # address: "Tokyo, Shibuya City, Sakuragaokacho, 15−19",
    artist: "Flume",
    latitude: 35.656655,
    longitude: 139.701640,
    genre: "Dance/Electronic"
  },
  {
    date: Faker::Date.between(from: 1.days.from_now, to: 7.days.from_now),
    venue: "SEL OCTAGON TOKYO",
    # address: "Tokyo, Minato City, Roppongi, 7 Chome−8−6",
    artist: "Joe Hertz",
    latitude: 35.665174,
    longitude: 139.729830,
    genre: "Dance/Electronic"
  },
  {
    date: Faker::Date.between(from: 14.days.ago, to: 6.days.ago),
    venue: "Billboard Live Tokyo",
    # address: "Tokyo, Minato City, Akasaka, 9 Chome−7−4",
    artist: "Purple Disco Machine",
    latitude: 35.666687,
    longitude: 139.730918,
    genre: "Disco"
  }
]

puts "3"

events.each do |event|
  
  new_event = Event.create(event)
  2.times do
    UsersEvent.create!(
      user: User.all.sample,
      event: new_event)
  end

  2.times do
    TracksUser.create!(
      event: new_event,
      user: new_event.users.sample,
      track: Track.all.sample)
  end
end

puts "4"

2.times do
  TracksUser.create!(
    event: Event.find_by(venue: "UNIT"),
    user: Event.find_by(venue: "UNIT").users.sample,
    track: Track.all.sample)
end
