class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to user_url(user)
  end

  helper_method :current_user

  private
  def redirect_user_if_logged_in
    redirect_to cats_url if current_user
  end

  def redirect_user_unless_logged_in
    redirect_to new_session_url unless current_user
  end
end
