class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:home]

  def library
    if user_signed_in?

      @user = current_user
      @tracks = @user.favorited_tracks

      if params[:event_id].present?
        event = Event.find(params[:event_id])
        @tracks = @tracks.joins(:tracks_users).where(tracks_users: { event: event }) if event
      end
    else
      redirect_to "/"
    end

  end

  def home
  end
end
