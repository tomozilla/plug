class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!
  
  def create
    if params[:errors]
      puts "Login Failed"
    else
      body = {
        grant_type: "authorization_code",
        code: params[:code],
        redirect_uri: ENV['REDIRECT_URL'],
        client_id: ENV['SPOTIFY_CLIENT_ID'],
        client_secret: ENV['SPOTIFY_CLIENT_SECRET']
      }

      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response.body)
      p auth_params
      header = {
        Authorization: "Bearer #{auth_params["access_token"]}" 
      }

      user_response = RestClient.get('https://api.spotify.com/v1/me', header)
      user_params = JSON.parse(user_response.body)
      user_params["images"].empty? ? image_url = nil : image_url = user_params["images"][0]["url"]
      @user = User.find_for_spotify(
        spotify_id: user_params["id"],
        email: user_params["email"],
        access_token: auth_params["access_token"],
        refresh_token: auth_params["refresh_token"],
        image_url: image_url
      )
      sign_in @user
      redirect_to root_path
    end

  end

end