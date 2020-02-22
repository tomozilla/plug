require 'json'
require 'open-uri'

class EventsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index]

  def index
    RefreshTokenService.refresh_token(current_user)
    FetchTracksService.downloadTracks(current_user)

    @events = Event.near([params[:lat], params[:lon]], 10)
    if params[:lat] && params[:lon]
      @main_event = @events.first
    end
  end

  def check_in
    users_event = UsersEvent.new
    users_event.user = current_user
    users_event.event = Event.find(params[:id])
    if users_event.save
      redirect_to event_path(users_event.event)
    else
      render :index
    end
  end

  def show
    @event = Event.find(params[:id])
    @event_users = @event.users
  end

  def event_params
    params.require(:event).permit(:date, :venue, :title, :artist)
  end
end
