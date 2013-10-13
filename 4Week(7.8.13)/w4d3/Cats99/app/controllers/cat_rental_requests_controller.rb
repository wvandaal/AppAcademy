class CatRentalRequestsController < ApplicationController

  def index

  end

  def new

  end

  def create
    request = CatRentalRequest.new(params[:cat_rental_request])
    if request.save
      redirect_to cat_path(request.cat_id)
    else
      flash[:error] = "invalid rental request"
      redirect_to new_cat_rental_request_path
    end
  end

  def update
    request = CatRentalRequest.find(params[:id])
    if params[:cat_rental_request][:status] == "approved"
      request.approve
    else
      unless request.update_attributes(status: params[:cat_rental_request][:status])
        flash[:error] = "status has already been #{request.status}"
      end
    end
    redirect_to cat_path(request.cat_id)
  end

end
