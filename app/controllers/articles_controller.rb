class ArticlesController < ApplicationController

  before_action :set_article, only:[:show, :edit, :update, :destroy]

def index
  q = params[:q]
  search_mine = current_user&.id
  if q && (q[:search_category] || q[:search_string])
    @articles = Article.includes(:category, :user)
    .search_by_category(q[:search_category])
    .search_by_string(q[:search_string])
    .order("id DESC")
    .page(params[:page]).per(10)
  elsif params[:user_id] == '0'
    @articles = Article.includes(:category, :user)
    .search_by_user(search_mine)
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

end
