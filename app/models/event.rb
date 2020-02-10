class Event < ApplicationRecord
  has_many :users, through: :usersEvent
  validates :date, presence: true
  validates :venue, presence: true
end
