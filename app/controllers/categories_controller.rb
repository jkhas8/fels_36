class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:destroy, :edit, :update, :create, :new]

  def index
    @categories = Category.all.paginate page: params[:page]
    @category = Category.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = 'Category created'
      redirect_to categories_url
    else
      render 'new'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = 'Category deleted'
    redirect_to categories_url
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes category_params
      flash[:success] = 'Category updated'
      redirect_to categories_url
    else
      render 'edit'
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
