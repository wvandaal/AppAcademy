class FavoritesController < ApplicationController
  before_filter :authenticate_user
  def index
    render json: User.find(params[:user_id]).contacts.where("listings.favorite = ?", true)
  end

end
