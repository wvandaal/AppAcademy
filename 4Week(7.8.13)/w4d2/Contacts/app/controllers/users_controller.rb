class UsersController < ApplicationController
  before_filter :authenticate_user
  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.new(params[:user])
    if user.save
      render :json => user
    else
      render :json => user.errors, status: :unprocessable_entity
    end
  end

  def favorites
    render json: User.find(params[:user_id]).contacts
      .where("listings.favorite = ?", true)
  end

  def destroy
    Listing.destroy_all(user_id: params[:id])
    user = User.find(params[:id])
    if (user.listings.empty? && user.inverse_listings.empty?)
      user.destroy
    end
    render json: User.all
  end

end
