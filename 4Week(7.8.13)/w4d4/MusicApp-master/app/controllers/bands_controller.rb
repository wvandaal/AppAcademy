class BandsController < ApplicationController
  before_filter :authorize_admin, :only => [:new, :create, :edit, :update]

  def index
    @bands = Band.all
  end

  def show
    @band = Band.includes(:albums).find(params[:id])
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(params[:band])
    if @band.save
      redirect_to @band
    else
      flash[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    @band.attributes = params[:band]
    if @band.save
      redirect_to @band
    else
      flash[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

end
