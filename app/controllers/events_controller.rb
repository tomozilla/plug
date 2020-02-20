require 'json'
require 'open-uri'

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @user = User.first
  end

  def create
  end

  def show
    @artists_track = ArtistsTrack.new(tracks_event_params)
    @tracks_user = current_user
    @tracks = current_user.tracks



  end

  def event_params
    params.require(:event).permit(:date, :venue, :title, :artist)
  end
end
