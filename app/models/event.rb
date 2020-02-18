class Event < ApplicationRecord
  has_many :users_events
  has_many :users, through: :users_events
  has_many :tracks_users
  has_many :favorited_tracks, through: :tracks_users, source: :track
  validates :date, presence: true
  validates :venue, presence: true
end
