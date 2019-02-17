class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update]
  def new
    @article = Article.new
  end

  def index
    @articles = Article.page(params[:page]).per(10).search(params[:search])
    @stories = Story.page(params[:page]).per(10).search(params[:search])
  end

  def show
    @article = Article.find(params[:id])
    @stories = @article.stories.all
  end

  def edit
    @article = Article.find(params[:id])
    @category_list = @article.categories.pluck(:name).join(",")
  end

  def create
    article = Article.new(article_params)
    article.user_id = current_user.id
    category_list = params[:category_list].split(",")
    article.save
    article.save_article_categories(category_list)
    redirect_to article_path(article)
  end

  def update
    @article = Article.find(params[:id])
    create_article_history
    @article.update(article_params)
    category_list = params[:category_list].split(",")
    @article.save_article_categories(category_list)
    redirect_to article_path(@article)
  end

  private

  def article_params
    params.require(:article).permit(:title, :mean, :cause)
  end
end
