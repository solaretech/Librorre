class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
    @stories = @article.stories.all
    @categories = Category.all
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
    article.save_categories(category_list)
    redirect_to article_path(article)
  end

  def update
    article= Article.find(params[:id])
    category_list = params[:category_list].split(",")
    article.update(article_params)
    article.save_categories(category_list)
    redirect_to article_path(article)
  end

  private

  def article_params
    params.require(:article).permit(:title, :mean, :cause)
  end
end
