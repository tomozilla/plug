class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :library]

  def library
    if user_signed_in?
      @user = User.first
      @user_tracks = user.tracks.order('created_at DESC')
    # else
    #   redirect_to "/"
    end
  end

  def home
  end
end
