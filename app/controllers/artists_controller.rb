class ArtistsController < ApplicationController
  def index
    @artists = current_user.artists
  end

  def new
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.save
    redirect_to artist_path(@artist)
  end

  def update
    @artist = Artist.find(artist_params)
    @artist.update(artist_params)
  end

  def delete
    @artist = Artist.find(params[:id])
    @artist.delete
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :genres, :image)
  end
end
