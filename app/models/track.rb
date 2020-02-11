class Track < ApplicationRecord
  has_many :artists, through: :artistsTracks
  has_many :artistsTracks
  has_many :users, through: :tracksUsers
  has_many :tracksUsers
  validates :name, presence: true
  validates :artists, presence: true
  validates :album, presence: true
  validates :spotify_id, presence: true
end
