require 'json'
require 'open-uri'

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    RefreshTokenService.refresh_token(current_user)
    FetchTracksService.downloadTracks(current_user)
    @user = User.first

    @events = Event.near([params[:lat], params[:lon]], 10)
  end

  def check_in
    users_event = UsersEvent.new
    users_event.user = current_user
    users_event.event = Event.find(params[:id])

    # @event_artist = @event.artist
    # artist_search = "https://api.spotify.com/v1/search?q=#{@event_artist}&type=artist"
    # token = {"Authorization" => "Bearer BQAMEXI6G__4MSPojgmNHCvLW9CYlP07Wk1Tf-VFK7f4i_vY3KiPgihodsTUt_ooxq25ckyJWcgn8lGj0MQcE9QnMuA2IjcOdIH3K75qg3mrYISldzlu-0Aur3AxAG3fkIhhyZmv8qledkEac2ejKSDSCVy4Sy52crdmT8whpBNbCaFfUEfrxMSO18hI3ybozTEwY35ows6lu_OWXhNL0cwSMXAkOpFjv-9jXaV8PMenQuCe2SB95NGERo2Gh8O56KeVeoSRK0o"}
    # artist_search_serialized = open(artist_search, token).read
    # search_result = JSON.parse(artist_search_serialized)
    # artist_id = parse_result["artists"]["items"].first["id"]
    # url = "https://api.spotify.com/v1/artists?ids=#{artist_id}"
    # data_serialized = open(url, token).read
    # data_result = JSON.parse(data_serialized)
    # artist_image_url = data["artists"].first["images"].first["url"]
    # file = URI.open(artist_image_url)

    # @event.photo.attach(io: file, filename: 'sample.png', content_type: 'image/png')
    if users_event.save
      redirect_to event_path(users_event.event)
    else
      render :index
    end
  end

  def show
  end

  def event_params
    params.require(:event).permit(:date, :venue, :title, :artist)
  end

end
