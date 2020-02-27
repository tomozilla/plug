class PagesController < ApplicationController
 skip_before_action :authenticate_user!, only: [:home, :dashboard]

  def library
    if user_signed_in?
      @user = current_user
      @tracks = @user.favorited_tracks
    else
      redirect_to "/"
    end
  end

  def home
    @tracks = current_user.tracks unless current_user.nil?
  end
end
