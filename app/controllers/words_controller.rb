class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    category_id = params[:filter] ? params[:filter][:category_id] : nil
    if category_id.nil?
      @words = Word.paginate page: params[:page]
    else
      @category = Category.find_by id: category_id
      if @category.nil?
        raise ActionController::RoutingError.new 'Not Found'
      else
        @learned = params[:filter][:learned]
        case @learned
        when "1"
          @words = @category.words_learned_by(current_user).
            paginate page: params[:page]
        when "0"
          @words = @category.words_not_learned_by(current_user).
            paginate page: params[:page]
        else
          @words = @category.words.paginate page: params[:page]
        end
      end
    end
  end
end
