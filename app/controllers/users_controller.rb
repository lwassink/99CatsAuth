class UsersController < ApplicationController
  before_action :redirect_user_if_logged_in, only: [:new, :create]
  def new
  end

  def create
    user = User.new(user_params)

    if user.valid?
      user.save

      if user.email
        msg = UserMailer.welcome_email(user)
        msg.deliver
      end

      login_user!(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
