class FetchTracksService
  SLACK_API_TOKEN = "xoxb-843568960375-867449413506-41hdhOLmF8OxaeEtFeSvbEf2"
  SPOTIFY_CLIENT_ID = "80a4b6a4fb4f4add9b6a8289eb936864"
  SPOTIFY_CLIENT_SECRET = "4542e9e43c5845ee8fae652b24ebffe9"
  def self.downloadTracks(user)
    header = {
      Authorization: "Bearer #{user.access_token}" 
    }
    tracks_response = RestClient.get("https://api.spotify.com/v1/me/tracks?limit=10", header)
    tracks_params = JSON.parse(tracks_response)
    tracks_params["items"].each do |item|
      spotify_id = item["track"]["id"]
      name = item["track"]["name"]
      album = item["track"]["album"]["artists"][0]["name"]
      if Track.find_by(spotify_id: spotify_id).nil?
        track = Track.create!(
          spotify_id: spotify_id,
          name: name,
          album: album)
          item["track"]["artists"].each do |artist|
            spotify_id = artist["id"]
            name = artist["name"]
            artist = Artist.create!(
              name: name,
              spotify_id: spotify_id)
            ArtistsTrack.create!(artist: artist, track: track)
          end
      else
        track = Track.find_by(spotify_id: spotify_id)
      end
      if TracksUser.find_by(user: user, track: track).nil?
        TracksUser.create!(user: user, track: track)
      end
    end
  end
end