class ArticlesController < ApplicationController

  before_action :set_article, only:[:show, :edit, :update, :destroy]

  def index
    @articles = Article.includes(:category).page(params[:page]).per(10)
  end

  def show
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
  end

  def update
    @article.update(article_params)
    redirect_to articles_path
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def find
    search_string = params[:search_string]
    @articles = Article.where('title LIKE ? or sentence LIKE ?', "%#{search_string}%", "%#{search_string}%")
  end

  private

  def article_params
    params[:article].permit(:title, :category_id, :sentence, :picture)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
