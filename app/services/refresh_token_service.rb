class RefreshTokenService
  SLACK_API_TOKEN = "xoxb-843568960375-867449413506-41hdhOLmF8OxaeEtFeSvbEf2"
  SPOTIFY_CLIENT_ID = "80a4b6a4fb4f4add9b6a8289eb936864"
  SPOTIFY_CLIENT_SECRET = "4542e9e43c5845ee8fae652b24ebffe9"
  def self.refresh_token(user)
    if user.access_token_expired?
      body = {
        grant_type: "refresh_token",
        refresh_token: user.refresh_token,
        client_id: SPOTIFY_CLIENT_ID,
        client_secret: SPOTIFY_CLIENT_SECRET
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
