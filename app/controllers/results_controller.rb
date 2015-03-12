class ResultsController < ApplicationController
  before_action :logged_in_user

  def index
    @lesson = Lesson.find params[:lesson_id]
  end
end
