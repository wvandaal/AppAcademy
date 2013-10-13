class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= session[:current_user_id] &&
      User.find_by_token(params[:token])
  end

  def logged_in?
    !!@current_user
  end

  def authenticate_user
    unless logged_in?
      raise "Log in, douchebag"
    else
      true
    end
  end

end
