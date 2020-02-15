class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def library
    if params[:venue].present?

      @events = Event.where(venue: params[:venue])
    else
      @events = Event.all
    end

    if user_signed_in?
      @user = current_user

      @my_events = @user.events
      @my_tracks = @user.tracks
    else
      redirect_to "/"
    end
  end

  def home
  end
end
