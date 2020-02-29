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

  def self.find_for_spotify(spotify_id:, email:, access_token:, refresh_token:)
    user = User.find_by(spotify_id: spotify_id)
    unless user.nil?
      user.update(access_token: access_token, refresh_token: refresh_token)
      puts "User token updated"
    else
      user = User.new(email: email, spotify_id: spotify_id)
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

  # def retrieve_user_image
  #   token = {"Authorization" => "BQC2xNtjjIqZ7WdV67g5ogKIiqg4jw2C1hAaf3WxFjd_d9xW_snnJDNOo5Ftmvqb2xXW-yVQ_AOWi7MjxBCNp5X1ONB9cGqnfa9aDfPr-o-geEqCDsgH0NCUCQrNZiQPBD1hxUZAK7-y4PoYaHsC9UpPS2maePr-QJfbkFEr5Qvnw1VYKW3MUMnOWu5TTlEI_kdgyCpC7fkE_rZV5o8QSpNM0pT1XOGbXOD6neigXvHwPD7Hd8wfSAdkm78ellmTMRnTR4n8VcY"}
  #   user_search = "https://api.spotify.com/v1/search?q=#{}&type=artis"
  #   artist_search_serialized = open(artist_search, token).read
  #   search_result = JSON.parse(artist_search_serialized)
  #   artist_id = search_result["artists"]["items"].first["id"]
  #   url = "https://api.spotify.com/v1/artists?ids=#{artist_id}"
  #   data_serialized = open(url, token).read
  #   data_result = JSON.parse(data_serialized)
  #   artist_image_url = data_result["artists"].first["images"].first["url"]
  # end

end
