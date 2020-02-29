class CreateNewLibraryService
  def self.create_playlist(user:, playlist_name:)
    RefreshTokenService.refresh_token(user)
    header = {
      accept: :json, 
      Authorization: "Bearer #{user.access_token}",
      content_type: :json
    }
    body = {
      'name' => playlist_name, 
      'description' => 'New playlist description'
    } 
    api_response = RestClient.post( "https://api.spotify.com/v1/users/#{user.spotify_id}/playlists", body.to_json, header )
    api_params = JSON.parse(api_response) unless api_response.nil?
    api_params["id"]
  end

  # CreateNewLibraryService.add_tracks_to_playlist(user: current_user, tracks: tracks, playlist_id: playlist)
  def self.add_tracks_to_playlist( user:, tracks:, playlist_id:)
    tracks_array = []
    tracks.each do |track|
      tracks_array << "spotify:track:#{track.spotify_id}"
    end
    header = {
      accept: :json, 
      Authorization: "Bearer #{user.access_token}",
      content_type: :json
    }
    body = {
      'uris' => tracks_array
    } 
    api_response = RestClient.post( "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks", body.to_json, header )
    api_params = JSON.parse(api_response) unless api_response.nil?
  end
end
