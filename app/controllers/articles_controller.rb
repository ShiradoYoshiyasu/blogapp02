class ArticlesController < ApplicationController

  before_action :set_article, only:[:show, :edit, :update, :destroy]
  before_action :logged_in_user, only:[:edit, :update, :new]

def index
  q = params[:q]
  if q && (q[:search_category] || q[:search_string] || q[:search_user])
    @articles = Article.includes(:category, :user)
    .search_by_category(q[:search_category])
    .search_by_string(q[:search_string])
    .search_by_user(q[:search_user], current_user&.id)
    .order("id DESC")
    .page(params[:page]).per(10)
  else
    @articles = Article.includes(:category, :user)
    .order("id DESC")
    .page(params[:page]).per(10)
  end
end

  def show
  end

  def new
    @article = Article.new
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
    if @article.user_id != current_user&.id
      destroy_user_session_path
      redirect_to new_user_session_path
    end
  end

  def update
    if @article.user_id == current_user&.id && @article.update(article_params)
     redirect_to articles_path
   else
     render 'edit'
   end
  end

  def destroy
    if @article.user_id != current_user&.id
      redirect_to new_user_session_path
    else
      @article.destroy
      redirect_to articles_path
    end
  end

  private

  def article_params
    params[:article].permit(:title, :category_id, :sentence, :picture, :user_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def logged_in_user
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

end
