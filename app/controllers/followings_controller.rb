class FollowingsController < ApplicationController
  before_action :logged_in_user

  def index
    @title = "Following"
    @user = User.find params[:user_id]
    @users = @user.following.paginate page: params[:page]
  end
end
