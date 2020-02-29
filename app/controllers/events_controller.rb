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
      @sub_events = @events[1..3]
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
    @event = Event.includes(users: :tracks).find(params[:id])
    @users = @event.users.where.not(id: current_user.id)
    @track_counter = {}
    @artist_counter = {}

    @users.each do |user|
      user.tracks_users.each do |user_track|
        @track_counter[user_track.track_id] ||= [0, user_track.track]
        @track_counter[user_track.track_id][0] += 1

        user_track.track.artists.each do |artist|
          @artist_counter[artist.id] ||= [0, artist]
          @artist_counter[artist.id][0] += 1
        end
      end

      @tracks = @track_counter.sort_by { |track_id, count| count[0] }.take(5).map { |_, count| count.second }
      @artists = @artist_counter.sort_by { |artist_id, count| count[0] }.take(5).map { |_, count| count.second }
    raise
    end
  end

  def star_track
    TracksUser.create!(
      event: Event.find(params["event"].to_i),
      track: Track.find(params["track"].to_i),
      source: "events",
      user: current_user)
      redirect_to event_path(params["event"])
  end

  def unstar_track
    TracksUser.find_by(
      event: Event.find(params["event"].to_i),
      track: Track.find(params["track"].to_i),
      source: "events",
      user: current_user).destroy
    redirect_to event_path(params["event"])
  end

  def event_params
    params.require(:event).permit(:date, :venue, :title, :artist)
  end

end
