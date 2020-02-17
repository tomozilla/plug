class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tracks_users
  has_many :users_events
  has_many :tracks, through: :tracks_users
  has_many :events, through: :users_events
  # has_many :favorited_tracks, -> { joins(tracks_users).where.not(tracks_users: { event: nil }) }, class_name: "Track"
  validates :email, presence: true

  def favorited_tracks
    tracks.joins(:tracks_users).where.not(tracks_users: { event: nil }).distinct
  end
end
