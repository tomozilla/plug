class Api::V1::AuthController < ApplicationController

  SLACK_API_TOKEN = "xoxb-843568960375-867449413506-41hdhOLmF8OxaeEtFeSvbEf2"
  SPOTIFY_CLIENT_ID = "80a4b6a4fb4f4add9b6a8289eb936864"
  SPOTIFY_CLIENT_SECRET = "4542e9e43c5845ee8fae652b24ebffe9"

  def spotify_request
    url = "https://accounts.spotify.com/authorize"
    query_params = {
      client_id: SPOTIFY_CLIENT_ID,
      response_type: 'code',
      redirect_uri: 'http://localhost:3000/api/v1/user',
      scope: "user-library-read 
      playlist-read-collaborative
      playlist-modify-private
      user-modify-playback-state
      user-read-private
      user-top-read
      playlist-modify-public",
     show_dialog: true
    }
    redirect_to "#{url}?#{query_params.to_query}"
  end
end