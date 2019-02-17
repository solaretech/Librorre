class StoriesController < ApplicationController
  def new
    @article = Article.find(params[:article_id])
    @story = @article.stories.new
    @story_topic = @story.story_topics.build
    @story_body = @story_topic.story_bodies.build
  end

  def show
    @story = Story.find(params[:id])              # 選択したストーリー
    @article = @story.article                     # 選択したストーリーに関連するエラー記事
    @stories = Story.page(params[:page]).per(10)  # 同一エラーに関するストーリー
    @topics = @story.story_topics                 # 見出し
    logging_visited_stories(@story)               # 閲覧履歴の記録
  end

  def edit
    @story = Story.find(params[:id])
    @category_list = @story.categories.pluck(:name).join(",")
  end

  def create
    article = Article.find(params[:article_id])
    story = article.stories.new(story_params)
    story.user_id = current_user.id
    category_list = params[:category_list].split(",")
    story.save
    story.save_story_categories(category_list)
    redirect_to story_path(story.id)
  end

  def update
    story = Story.find(params[:id])
    story.update(story_params)
    category_list = params[:category_list].split(",")
    story.save_story_categories(category_list)
    redirect_to story_path(story)
  end

  def destroy
    story = Story.find(params[:id])
    article = story.article
    story.destroy
    redirect_to article_path(article)
  end

  private

  def story_params
    params.require(:story).permit(
      :title,
        story_topics_attributes: [
          :id,
          :title,
          :_destroy,
          story_bodies_attributes: [
            :id,
            :content,
            :text_type,
            :_destroy
          ]
        ]
      )
  end
end
