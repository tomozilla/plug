class FetchTracksService
  def self.downloadTracks(user)
    header = {
      Authorization: "Bearer #{user.access_token}" 
    }
    tracks_response = RestClient.get("https://api.spotify.com/v1/me/tracks?limit=50", header)
    tracks_params = JSON.parse(tracks_response)
    tracks_params["items"].each do |item|
      spotify_id = item["track"]["id"]
      name = item["track"]["name"]
      album_id = item["track"]["album"]["id"]
      album = item["track"]["album"]["name"]
      if Track.find_by(spotify_id: spotify_id).nil?
        track = Track.create!(
          spotify_id: spotify_id,
          name: name,
          album: album)
          item["track"]["album"]["artists"].each do |artist|
            spotify_id = artist["id"]
            name = artist["name"]
            if Artist.find_by(spotify_id: spotify_id).nil?
              artist = Artist.create!(
                name: name,
                spotify_id: spotify_id)
              ArtistsTrack.create!(artist: artist, track: track)
            end
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