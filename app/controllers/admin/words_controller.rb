module Admin
  class WordsController < ApplicationController
    before_action :logged_in_user
    before_action :admin_user, only: [:destroy, :edit, :update, :create, :new]
    before_action :get_category

    def new
      @word = @category.words.build
      4.times {@word.answers.build}
    end

    def create
      @word = @category.words.new word_params
      if @word.save
        flash[:success] = "Word added"
        redirect_to words_path
      else
        render :new
      end
    end

    def destroy
      @category.words.find(params[:id]).destroy
      flash[:success] = "Word deleted"
      redirect_to words_url
    end

    def edit
      @word = @category.words.find params[:id]
    end

    def update
      @word = @category.words.find params[:id]
      if @word.update_attributes word_params
        flash[:success] = "Word updated"
        redirect_to words_url
      else
        render :edit
      end
    end

    private
    def word_params
      params.require(:word).permit(:content, :meaning,
        answers_attributes: [:id, :content, :_destroy, :correct])
    end

    def get_category
      @category = Category.find params[:category_id]
    end
  end
end
