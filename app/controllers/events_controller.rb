
class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @user = User.first
  end

  def create
  end

  def show
    @event = Event.includes(users: :tracks).find(params[:id])
    @users = @event.users

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
    end


  end

  def event_params
    params.require(:event).permit(:date, :venue, :title, :artist)
  end
end
