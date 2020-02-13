class Event < ApplicationRecord
  has_many :usersEvents
  has_many :users, through: :usersEvents
  validates :date, presence: true
  validates :venue, presence: true
end
