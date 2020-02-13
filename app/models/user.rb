class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tracksUsers
  has_many :tracks, through: :tracksUser
  has_many :usersEvents
  has_many :events, through: :usersEvents
end
