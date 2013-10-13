class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :logged_in?

  def current_user
  	return nil unless session[:token]
  	@current_user = User.find_by_session_token(session[:token])
  end

  def logged_in?
  	!!current_user
  end

  def generate_token
  	token = SecureRandom.urlsafe_base64
  end

end
