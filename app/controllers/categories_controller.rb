class CategoriesController < ApplicationController

=begin  def upcate
    @categories = Category.all
  end
=end
  def upcreate
    @category = Category.new(category_params)
    @category.save
  end

  def upname
    @category_names = Category.all
  end

  def index
    @categories = Category.page(params[:page]).per(5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params[:category].permit(:name)
  end

end
