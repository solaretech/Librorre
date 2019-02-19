class StoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def new
    @article = Article.find(params[:article_id])
    @story = @article.stories.new
    @story_topic = @story.story_topics.build
    @story_body = @story_topic.story_bodies.build
  end

  def show
    @story = Story.find(params[:id])              # 選択したストーリー
    @article = @story.article                     # 選択したストーリーに関連するエラー記事
    @stories = Story.order(:created_at).reverse_order.page(params[:page]).per(10)  # 同一エラーに関するストーリー
    @topics = @story.story_topics                 # 見出し
    @story_comments = @story.story_comments.reverse
    @story_comment = StoryComment.new
    logging_visited_stories(@story)               # 閲覧履歴の記録
  end

  def edit
    @story = Story.find(params[:id])
    @category_list = @story.categories.pluck(:name).join(",")
  end

  def create
    @article = Article.find(params[:article_id])
    @story = @article.stories.new(story_params)
    @story.user_id = current_user.id
    if @story.save
      @category_list = params[:category_list].split(",")
      @story.save_story_categories(@category_list)
      redirect_to story_path(@story), success: 'ストーリーを作成しました。'
    else
      @story_topic = @story.story_topics.build
      @story_body = @story_topic.story_bodies.build
      flash.now[:alert] = 'ストーリーの作成に失敗しました。'
      render :new
    end
  end

  def update
    @story = Story.find(params[:id])
    @category_list = params[:category_list].split(",")
    if @story.update(story_params)
      @story.save_story_categories(@category_list)
      redirect_to story_path(@story), success: 'ストーリーを更新しました'
    else
      flash.now[:alert] = 'ストーリーの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @story = Story.find(params[:id])
    article = story.article
    if story.destroy
      redirect_to article_path(article), success: 'ストーリーを削除しました'
    else
      @category_list = params[:category_list].split(",")
      flash.now[:alert] = 'ストーリーの更新に失敗しました。'
      render :edit
    end
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
