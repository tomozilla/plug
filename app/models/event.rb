class Event < ApplicationRecord
  has_many :usersEvents
  has_many :users, through: :usersEvents
  validates :venue, presence: true
  geocoded_by :venue
  after_validation :geocode
  # , if: :will_save_change_to_address?
end
