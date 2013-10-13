class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.new(params[:user])
    if user.save
      redirect_to posts_path
    else
      redirect_to :back
    end
  end

end
