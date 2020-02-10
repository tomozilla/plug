class Event < ApplicationRecord
  has_many :users, through: :users_events
  validates :date, presence: true
  validates :venue, presence: true
end
