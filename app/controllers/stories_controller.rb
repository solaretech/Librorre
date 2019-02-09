class StoriesController < ApplicationController
  def new
    @article = Article.find(params[:article_id])
    @story = @article.stories.new
    @story_topic = @story.story_topics.build
    @story_body = @story_topic.story_bodies.build
  end

  def show
    @story = Story.find(params[:id])  # 選択したストーリー
    @article = @story.article         # 選択したストーリーに関連するエラー記事
    @stories = Story.all       # 同一エラーに関するストーリー
    @topics = @story.story_topics
  end

  def edit
  end

  def create
    article = Article.find(params[:article_id])
    story = article.stories.new(story_params)
    story.user_id = current_user.id
    category_list = params[:category_list].split(",")
    story.save!
    story.save_story_categories(category_list)
    redirect_to story_path(story.id)
  end

  private

  def story_params
    params.require(:story).permit(
      :title,
        story_topics_attributes: [
          :title,
          :_destroy,
          story_bodies_attributes: [
            :content,
            :text_type,
            :_destroy
          ]
        ]
      )
  end
end
