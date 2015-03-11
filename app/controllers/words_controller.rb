class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @category_id = params[:category_id]
    @learned = params[:learned].to_i
    @words = if @category_id.blank?
      if @learned == 1 || @learned == -1
       current_user.send "#{'not_' if @learned == -1}learned_words"
      else
        Word.all
      end
    else
      @category = Category.find @category_id
      if @learned == 1 || @learned == -1
        @category.send "words#{'_not' if @learned == -1}_learned_by", current_user
      else
        @category.words
      end
    end
    @words = @words.paginate page: params[:page]
  end
end
