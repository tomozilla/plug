class TracksController < ApplicationController
  def index
    @tracks = current_user.tracks
  end

  def create
    @track = Track.new(track_params)
    @track.save
    redirect_to dashboard_path
  end

  def update
    if @track.update(track_params)
      redirect_to dashboard_path
    end
  end

  private

  def track_params
    params.require(:track).permit(:name, :album, :artists)
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
  end
end