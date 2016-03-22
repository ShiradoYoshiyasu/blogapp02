class ArticlesController < ApplicationController

  before_action :set_article, only:[:show, :edit, :update, :destroy]
  before_action :check_logged_in, only:[:edit, :update, :new]
  before_action :back_different_user, only:[:edit, :update, :destroy]

def index
  q = params[:q]
  if q && (q[:search_category] || q[:search_string] || q[:search_user])
    @articles = Article.includes(:category, :user)
    .search_by_category(q[:search_category])
    .search_by_string(q[:search_string])
    .search_by_user(q[:search_user], current_user&.id)
    .order("id DESC")
    .page(params[:page]).per(9)
  else
    @articles = Article.includes(:category, :user)
    .order("id DESC")
    .page(params[:page]).per(9)
  end
end

  def show
  end

  def new
    @article = Article.new
    @category_names = Category.all.pluck(:name)
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    @category_names = Category.all.pluck(:name)
  end

  def update
    if @article.update(article_params)
     redirect_to articles_path
   else
     render 'edit'
   end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params[:article].permit(:title, :category_id, :sentence, :picture, :user_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def check_logged_in
    unless user_signed_in?
      redirect_to new_user_registration_path, notice: 'サービス利用のためにはログインしてください'
    end
  end

  def back_different_user
    if @article.user_id != current_user&.id
      redirect_to articles_path, notice: '権限のない記事のためアクセスできません'
    end
  end


end
