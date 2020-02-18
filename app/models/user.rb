class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tracksUsers
  has_many :usersEvents
  has_many :tracks, through: :tracksUsers
  has_many :events, through: :usersEvents
  validates :email, presence: true
  validates :spotify_id, presence: true

  def self.find_for_spotify(spotify_id:, email:, access_token:, refresh_token:)
    user = User.find_by(spotify_id: spotify_id)
    if user
      user.update(access_token: access_token, refresh_token: refresh_token)
    else
      user = User.new(email: email, spotify_id: spotify_id)
      user.password = Devise.friendly_token[0,20]
      user.access_token = access_token
      user.refresh_token = refresh_token
      user.save
    end

    return user
  end
end
