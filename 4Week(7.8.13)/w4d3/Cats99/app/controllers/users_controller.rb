class UsersController < ApplicationController

  def new

  end

  def create
    user = User.new(params[:user])
    if user.save
      user.update_attributes(session_token: generate_token)
      session[:session_token] = user.session_token
      redirect_to cats_path
    else
      flash[:error] = "invalid username/password"
      redirect_to new_user_path
    end
  end

end
