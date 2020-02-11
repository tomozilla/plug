class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def new
  end

  def create
    @artist = Artist.new(params[:artist])
    @artist.save
  end

  def update
    @artist = Artist.find(params[:id])
    @artist.update(params[:artist])
  end

  def delete
    @artist = Artist.find(params[:id])
    @artist.delete

    redirect_to artists_path
  end
end
