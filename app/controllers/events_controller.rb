class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    RefreshTokenService.refresh_token(current_user)
    FetchTracksService.downloadTracks(current_user)
    @user = User.first
  end

  def create
  end

  def show
  end
end
