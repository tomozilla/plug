class GetAlbumService
  def self.getAlbumName(user, album_id)
    header = {
      Authorization: "Bearer #{user.access_token}" 
    }
    album_response = RestClient.get("https://api.spotify.com/v1/albums/#{album_id}", header)
    album_params = JSON.parse(album_response)
    album_params["name"]
  end
end