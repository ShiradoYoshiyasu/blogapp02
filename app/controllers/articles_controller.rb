class ArticlesController < ApplicationController

  before_action :set_article, only:[:show, :edit, :update, :destroy]

  def index
    @articles = Article.includes(:category, :user).page(params[:page]).per(10)
  end

  def show
    p params
    p "あああああああああああああああああああああああああ"
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to articles_path
    p article_params
    p "あああああああああああああああああああああああああ"
  end

  def edit
    p params
    p "あああああああああああああああああああああああああ"
  end

  def update
    @article.update(article_params)
    redirect_to articles_path
  end

  def destroy
    @article.destroy
    p params
    p "あああああああああああああああああああああああああ"
    redirect_to articles_path
  end

  def find
    q = params[:q]
    @articles = Article.includes(:category, :user).where('category_id = ? and title LIKE ? or sentence LIKE ?',"#{q[:search_category]}", "%#{q[:search_string]}%", "%#{q[:search_string]}%")
  end

  private

  def article_params
    params[:article].permit(:title, :category_id, :sentence, :picture, :user_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
