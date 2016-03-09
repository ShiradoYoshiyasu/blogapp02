class ArticlesController < ApplicationController

  def index
    @articles = Article.page(params[:page]).per(10)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to articles_path
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  def find
    search_string = params[:search_string]
    @articles = Article.where("title LIKE '%" + search_string + "%'")
  end

  private

  def article_params
    params[:article].permit(:title, :category_id, :sentence)
  end

end
