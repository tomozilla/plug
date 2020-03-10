class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tracks_users
  has_many :users_events
  has_many :tracks, through: :tracks_users
  has_many :events, through: :users_events
  has_one_attached :photo
  # has_many :favorited_tracks, -> { joins(tracks_users).where.not(tracks_users: { event: nil }) }, class_name: "Track"
  validates :email, presence: true
  validates :spotify_id, presence: true

  def self.find_for_spotify(spotify_id:, email:, access_token:, refresh_token:, image_url:)
    user = User.find_by(spotify_id: spotify_id)
    unless user.nil?
      user.update(access_token: access_token, refresh_token: refresh_token, image_url: image_url)
      puts "User token updated"
    else
      user = User.new(email: email, spotify_id: spotify_id, image_url: image_url)
      user.password = Devise.friendly_token[0,20]
      user.access_token = access_token
      user.refresh_token = refresh_token
      user.save!
      puts "User saved"
    end
    return user
  end

  def access_token_expired?
    (Time.now - self.updated_at) > 3300
  end

  def favorited_tracks
    tracks.joins(:tracks_users).where.not(tracks_users: { event: nil }).distinct
  end

end
