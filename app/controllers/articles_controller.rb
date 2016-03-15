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

=begin

  def index
  #以下あまりにも助長なコード
    q = params[:q]
    search_mine = params[:search_mine]
    if q
      if q[:search_category] != ""
        @articles = Article.includes(:category, :user).where('category_id =  :category and (title LIKE :string or sentence LIKE :string)', category: "#{q[:search_category]}", string: "%#{q[:search_string]}%").order("id DESC").page(params[:page]).per(10)
      else
        @articles = Article.includes(:category, :user).where('title LIKE :string or sentence LIKE :string', string: "%#{q[:search_string]}%").order("id DESC").page(params[:page]).per(10)
      end
    elsif search_mine
      @articles = Article.includes(:category, :user).where('user_id = ?', "#{search_mine}").order("id DESC").page(params[:page]).per(10)
    else
      @articles = Article.includes(:category, :user).order("id DESC").page(params[:page]).per(10)
    end
  end

=end

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
  end

  def update
    if @article.user_id == current_user.id && @article.update(article_params)
     redirect_to articles_path
   else
     render 'edit'
   end
  end

  def destroy
    if @article.user_id == current_user.id
      @article.destroy
      redirect_to articles_path
    else
      render 'edit'
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
