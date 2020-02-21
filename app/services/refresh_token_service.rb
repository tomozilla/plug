class RefreshTokenService
  def self.refresh_token(user)
    if user.access_token_expired?
      body = {
        grant_type: "refresh_token",
        refresh_token: user.refresh_token,
        client_id: ENV['SPOTIFY_CLIENT_ID'],
        client_secret: ENV['SPOTIFY_CLIENT_SECRET']
        
      }

      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response)
      user.update(access_token: auth_params["access_token"])
      user.save!
    else
      puts "Current User's Token is not expired"
    end
  end
end
