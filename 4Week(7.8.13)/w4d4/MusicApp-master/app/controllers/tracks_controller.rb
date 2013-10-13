class TracksController < ApplicationController
  before_filter :authorize_admin, :only => [:new, :create, :edit, :update]

  def index
    @band = Band.find(params[:band_id])
    @tracks = @band.tracks.includes(:album)
  end

  def show
    @track = Track.find(params[:id])
    @notes = @track.notes.includes(:user)
  end

  def new
    @track = Track.new
  end

  def create
    @track = Album.find(params[:album_id]).tracks.build(params[:track])
    if @track.save
      redirect_to @track
    else
      flash[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    @track.attributes = params[:track]
    if @track.save
      redirect_to @track
    else
      flash[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    album = @track.album
    @track.destroy
    redirect_to album
  end

end
