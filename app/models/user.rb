class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tracks, through: :tracksUsers
  has_many :events, through: :usersEvents
  validates :email, presence: true
  validates :genres, presence: true
  validates :spotify_user_id, presence: true
end
