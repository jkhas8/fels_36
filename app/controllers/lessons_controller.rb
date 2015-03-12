class LessonsController < ApplicationController
  before_action :logged_in_user

  def index
    @category = Category.find params[:category_id]
    @lessons = @category.lessons.select do |lesson|
      current_user? lesson.user
    end.paginate page: params[:page]
  end

  def new
  end

  def create
    @category = Category.find params[:category_id]
    @lesson = Lesson.new user: current_user, category: @category
    if params[:lesson_id].blank?
      words = @category.words.sample 20
    else
      current_lesson = Lesson.find params[:lesson_id]
      words = current_lesson.results.map(&:word)
    end
    if words.size > 0
      words.shuffle.each do |word|
        @lesson.results.build word: word
      end
      if @lesson.save
        redirect_to category_lesson_path @category, @lesson
      else
        flash[:warning] = "Can not create lessons, try again later!"
        redirect_to root_path
      end
    else
      flash[:warning] = "Sorry, this lesson doesn't have words."
      redirect_to categories_path
    end
  end

  def update
    @lesson = Lesson.find params[:id]
    if !@lesson.learned && current_user?(@lesson.user)
      @lesson.learned = true
      if @lesson.update_attributes params_lesson
        redirect_to lesson_results_path(@lesson)
      end
    else
      flash[:warning] = "You had learned this lesson!" if @lesson.learned
      redirect_to lesson_results_path @lesson
    end
  end

  def show
    @lesson = Lesson.find params[:id]
    if @lesson.learned || !current_user?(@lesson.user)
      redirect_to lesson_results_path(@lesson)
    end
  end

  private
  def params_lesson
    params.require(:lesson).permit(results_attributes: [:id, :answer_id])
  end
end
