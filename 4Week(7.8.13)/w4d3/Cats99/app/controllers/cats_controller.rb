class CatsController < ApplicationController
  before_filter :check_owner, only: [:edit, :update]

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.includes(:rental_requests).find(params[:id])
    @user = current_user
  end

  def new
    @user = current_user
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def create
    cat = Cat.new(params[:cat])
    if cat.save
      redirect_to cats_path
    else
      flash[:error] = "invalid field"
      redirect_to new_cat_path
    end
  end

  def update
    cat = Cat.find(params[:id])
    cat.attributes = params[:cat]
    if cat.save
      redirect_to cat
    else
      flash[:error] = "invalid field"
      redirect_to edit_cat_path(params[:id])
    end
  end

  private

  def check_owner
    # p !current_user || Cat.find(params[:id]).user_id != current_user.id
    if !current_user || Cat.find(params[:id]).user_id != current_user.id
      flash[:error] = "cannot edit other users' cats"
      redirect_to cats_path
    end
  end

end
