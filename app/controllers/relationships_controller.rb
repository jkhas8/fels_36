class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find_by id: params[:followed_id]
    unless user.nil?
      current_user.follow user unless user.followers.include? current_user
    end
    redirect_to user
  end

  def destroy
    relationship = Relationship.find_by id: params[:id]
    current_user.unfollow relationship.followed unless relationship.nil?
    redirect_to :back
  end
end
