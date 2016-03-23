class CategoriesController < ApplicationController

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'カテゴリーを追加しました' }
        format.js {}
      else
        format.html { render 'new'}
        format.js {}
      end
    end
  end

  def index
    @categories = Category.page(params[:page]).per(5).order("id")
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: 'カテゴリーを更新しました'
    else
      render 'new'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: 'カテゴリーを削除しました'
  end

  private

  def category_params
    params[:category].permit(:name)
  end

end
