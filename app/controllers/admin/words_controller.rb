module Admin
  class WordsController < ApplicationController
    before_action :logged_in_user
    before_action :admin_user, only: [:destroy, :edit, :update, :create, :new]

    def new
      @category = Category.find params[:category_id]
      @word = @category.words.build
      4.times {@word.answers.build}
    end

    def create
      @category = Category.find params[:category_id]
      @word = @category.words.new word_params
      if @word.save
        flash[:success] = "Word added"
        redirect_to words_path
      else
        render :new
      end
    end

    private
    def word_params
      params.require(:word).permit(:content, :meaning,
        :answers_attributes => [:content, :_destroy, :correct])
    end
  end
end
