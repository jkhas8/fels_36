class WordsController < ApplicationController
  before_action :logged_in_user

  helper WordsHelper

  def index
    category_id = params[:word] ? params[:word][:category_id] : nil
    @learned = params[:word] ? params[:word][:learned].to_i : nil
    @words = if category_id.blank?
      if @learned == 1 || @learned == 0
       current_user.send "#{'not_' if @learned == 0}learned_words"
      else
        Word.all
      end
    else
      @category = Category.find category_id
      if @learned == 1 || @learned == 0
        @category.send "words#{'_not' if @learned == 0}_learned_by", current_user
      else
        @category.words
      end
    end
    @words = @words.paginate page: params[:page]
  end
end
