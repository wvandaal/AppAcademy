class ApplicationController < ActionController::Base
  protect_from_forgery


  def generate_token
    token = SecureRandom.urlsafe_base64
    while User.pluck(:session_token).include?(token)
      token = SecureRandom.urlsafe_base64
    end
    token
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end
end
