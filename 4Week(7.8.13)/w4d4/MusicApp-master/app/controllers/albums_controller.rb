class AlbumsController < ApplicationController
  before_filter :authorize_admin, :only => [:new, :create, :edit, :update]

  def index
    @albums = Album.all
  end

  def show
    @album = Album.includes(:tracks).find(params[:id])
  end

  def new
    @album = Album.new
  end

  def create
    @album = Band.find(params[:band_id]).albums.build(params[:album])
    if @album.save
      redirect_to @album
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    @album.attributes = params[:album]
    if @album.save
      redirect_to @album
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    band = @album.band
    @album.destroy
    redirect_to band
  end

end
