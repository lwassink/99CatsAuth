class SessionController < ApplicationController
  before_action :redirect_user_if_logged_in, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by_credentials(
                  session_params[:username],
                  session_params[:password])
    if user
      login_user!(user)
    else
      flash.now[:errors] = ["Incorrect username or password"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:user).permit(:username, :password)
  end
end
