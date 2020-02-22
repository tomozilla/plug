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

i = 0
3.times do
  Event.create!(
    date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now),
    address: address_choice[i],
    venue: location_choice[i])
  i = i + 1
end