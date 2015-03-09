class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all.paginate page: params[:page]
    @category = Category.new if current_user.admin?
    @lesson = Lesson.new
  end

end
