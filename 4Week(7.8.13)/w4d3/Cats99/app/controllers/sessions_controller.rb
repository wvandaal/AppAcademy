class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.authenticate(params[:user])
    p user
    if user
      user.update_attributes(session_token: generate_token)
      session[:session_token] = user.session_token
      redirect_to cats_path
    else
      flash[:error] = "invalid username/password"
      redirect_to new_session_path
    end
  end

  def destroy
    user = User.find_by_session_token(session[:session_token])
    if user
      user.session_token = nil
      user.save
      session[:session_token] = nil
    else
      flash[:error] = "Not logged in"
    end
    redirect_to new_session_path
  end

  def show
    render json: session
  end

end
