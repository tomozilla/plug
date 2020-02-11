class Event < ApplicationRecord
  has_many :users, through: :usersEvents
  has_many :usersEvents
  validates :date, presence: true
  validates :venue, presence: true
end
