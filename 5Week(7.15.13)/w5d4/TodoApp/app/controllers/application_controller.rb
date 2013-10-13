class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
  	return nil unless session[:token]
  	User.find_by_session_token(session[:token])
  end

  def logged_in?
  	!!current_user
  end

  def generate_token
  	token = SecureRandom.urlsafe_base64
  	while User.find_by_session_token(token)
  		token = SecureRandom.urlsafe_base64
  	end
  	token
  end
end
