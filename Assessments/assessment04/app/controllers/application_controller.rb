class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :logged_in?
  helper_method :current_user

  def generate_session_token
		token = SecureRandom.urlsafe_base64
  end

  def current_user
  	@current_user = session[:token] && User.find_by_session_token(session[:token])
  end

  def logged_in?
  	!!current_user
  end

end
