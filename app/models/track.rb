class Track < ApplicationRecord
  has_many :tracksUsers
  has_many :artistsTracks
  has_many :artists, through: :artistsTracks
  has_many :users, through: :tracksUsers
  validates :name, presence: true
  validates :album, presence: true
  validates :spotify_id, presence: true
end
