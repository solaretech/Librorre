class ArticlesController < ApplicationController
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
    article= Article.find(params[:id])
    # article_historyに編集履歴を追加
    history = ArticleHistory.new
    history.article_id = article.id
    history.user_id = current_user.id
    history.title = article.title
    history.mean = article.mean
    history.cause = article.cause
    history.save
    # articleの更新
    category_list = params[:category_list].split(",")
    article.update(article_params)
    article.save_article_categories(category_list)
    redirect_to article_path(article)
  end

  private

  def article_params
    params.require(:article).permit(:title, :mean, :cause)
  end
end
