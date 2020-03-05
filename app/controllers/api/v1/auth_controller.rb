class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_user!

  def spotify_request
    url = "https://accounts.spotify.com/authorize"
    query_params = {
      response_type: 'code',
      redirect_uri: ENV['REDIRECT_URL'],
      client_id: ENV['SPOTIFY_CLIENT_ID'],
      scope: "user-library-read 
      user-read-email
      playlist-read-collaborative
      playlist-modify-private
      user-modify-playback-state
      user-read-private
      user-top-read
      playlist-modify-private
      playlist-modify-public
      streaming",
     show_dialog: true
    }
    redirect_to "#{url}?#{query_params.to_query}"
  end

end