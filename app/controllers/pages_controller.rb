class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :library, :scan_events]

  def library
    if current_user.nil?
      redirect_to api_v1_login_path
    else
      @user = current_user
      @tracks = @user.favorited_tracks
      start_date = 1.days.from_now
      end_date = 7.days.from_now
    end
  end

  def export_spotify
    playlist_id = CreateNewLibraryService.create_playlist(user: current_user, playlist_name: params["playlist"]["name"])
    CreateNewLibraryService.add_tracks_to_playlist(user: current_user, tracks: current_user.favorited_tracks, playlist_id: playlist_id)
    current_user.tracks_users.destroy_all
    redirect_to "https://open.spotify.com/playlist/#{playlist_id}"
  end

  def home
    @tracks = current_user.tracks unless current_user.nil?
  end

  def scan_events
    redirect_to api_v1_login_path if current_user.nil?
  end

end
