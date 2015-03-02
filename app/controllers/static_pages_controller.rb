class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = current_user.feed.recent_first.paginate page: params[:page]
    end
  end

  def help
  end

  def contact
  end

  def about
  end
end
