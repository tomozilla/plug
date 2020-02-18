class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @user = User.first
  end

  def create
  end

  def show
    @tracks = current_user.tracks

  end
end
