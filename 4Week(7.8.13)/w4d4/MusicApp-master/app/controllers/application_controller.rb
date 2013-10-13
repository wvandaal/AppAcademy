class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :is_admin?, :logged_in?, :current_user

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user
    redirect_to new_session_url unless logged_in?
  end

  def is_admin?
    (current_user && current_user.admin)
  end

  def authorize_admin
    unless is_admin?
      flash[:errors] = ["Must be admin to do that"]
      redirect_to new_session_url
    end
  end
end
