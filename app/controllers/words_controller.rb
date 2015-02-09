class WordsController < ApplicationController

  def index
    category_id = params[:filter][:category]
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

  def new
  end
end
