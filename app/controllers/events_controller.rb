class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @events = Event.near([params[:lat], params[:lon]], 10)
    #event model needs display_name and artist(hash artist in perf array)
  end

  def create
  end

  def show
    params[:id]
  end

  def event_params
    params.require(:event).permit(:date, :venue)
  end
end
