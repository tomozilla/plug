require 'json'
require 'open-uri'

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if params[:lat] && params[:lon]
      today = 0.days.from_now
      @events = Event.near([params[:lat], params[:lon]], 10).where(date: today.beginning_of_day..today.end_of_day)
      @main_event = @events.first
      @sub_events = @events[1..4]
    end
    if current_user.nil?
      redirect_to api_v1_login_path
    else
      RefreshTokenService.refresh_token(current_user)
      FetchTracksService.downloadTracks(current_user)
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
    admin_user = User.find_by(email: ENV['ADMIN_EMAIL'])
    RefreshTokenService.refresh_token(admin_user)
    @admin_token = admin_user.access_token
    @event = Event.includes(users: :tracks).find(params[:id])
    @users = @event.users.where.not(id: current_user.id)
    @track_counter = {}
    @users.each do |user|
      user.tracks_users.each do |user_track|
        @track_counter[user_track.track_id] ||= [0, user_track.track]
        @track_counter[user_track.track_id][0] += 1
      end
      @tracks = @track_counter.sort_by { |track_id, data| data.first }.reverse!.take(20).map { |_, data| data.second }
    end
  end

  def star_track
    @tracksUser = TracksUser.create!(
      event: Event.find(params["event"].to_i),
      track: Track.find(params["track"].to_i),
      source: "events",
      user: current_user)
    @event = @tracksUser.event
    @track = @tracksUser.track
    @number_of_likes = getLikes(@tracksUser)
    render "events/refresh_card"
  end

  def unstar_track
    @tracksUser = TracksUser.find_by(
      event: Event.find(params["event"].to_i),
      track: Track.find(params["track"].to_i),
      source: "events",
      user: current_user)
    @event = @tracksUser.event
    @track = @tracksUser.track
    @number_of_likes = getLikes(@tracksUser)
    @tracksUser.destroy
    render "events/refresh_card"
  end

  def getLikes(tracksUser)
    @users = @event.users.where.not(id: current_user.id)
    @track_counter = {}

    @users.each do |user|
      user.tracks_users.each do |user_track|
        @track_counter[user_track.track_id] ||= [0, user_track.track]
        @track_counter[user_track.track_id][0] += 1
      end
      @tracks = @track_counter.sort_by { |track_id, data| data.first }.take(20).map { |_, data| data.second }
    end
    @track_counter[@track.id][0]
  end

  def event_params
    params.require(:event).permit(:date, :venue, :title, :artist)
  end

end
