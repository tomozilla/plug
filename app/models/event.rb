class Event < ApplicationRecord
  has_many :users_events
  has_many :users, through: :users_events
  has_many :tracks_users
  has_many :favorited_tracks, through: :tracks_users, source: :track
  validates :venue, presence: true
  # geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo
  after_create :retrieve_artist_image
  # after_create :retrieve_city_district
  geocoded_by :address
  # , if: :will_save_change_to_address?
  def retrieve_artist_image
    require "open-uri"
    require "json"
    search_word = venue
    header = {
      Authorization: "563492ad6f91700001000001dd3686cea808431a9d74a817439f2fdb" 
    }
    pexels_response = RestClient.get("https://api.pexels.com/v1/search?query=#{search_word}&per_page=2&page=1", header)
    pexels_params = JSON.parse(pexels_response.body)
    print "==============================small url=============================="
    unless pexels_params["photos"][0].nil?
      small_image_url = pexels_params["photos"][0]["src"]["small"]
    # file = URI.open(small_image_url)
      open('image.jpg', 'wb') do |file|
        print "==============================output=============================="
        p file << open(small_image_url).read
        photo.attach(io: File.open(file), filename: "#{artist}.jpg", content_type: 'image/jpg') unless File.zero?(file)
        file.close
      end
    end
    
    unless sub_event
      #find address from venue
      address = API with venue???
      # Geocode to find coordinates from address
      # Save to Event Model
      self.latitude = Geocoder.search(address)[0].latitude
      self.longitude = Geocoder.search(address)[0].longitude
      save
    end
  end
end
