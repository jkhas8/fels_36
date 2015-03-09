class SessionsController < ApplicationController
  before_action :check_login, only: [:new]

  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or root_path
    else
      flash.now[:danger] = 'Invalid email or password!'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def check_login
    if logged_in?
      flash[:warning] = "You had been logged in."
      redirect_to root_path
    end
  end
end
