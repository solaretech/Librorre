class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create_article_history
    @new_history = ArticleHistory.new
    @new_history.article_id = @article.id
    @new_history.user_id = current_user.id
    @new_history.title = @article.title
    @new_history.mean = @article.mean
    @new_history.cause = @article.cause
    @new_history.save
  end

  # ユーザーがストーリーページを表示した時、そのページの情報をVisitedモデルに保存
  def logging_visited_stories(story_visited)
    if user_signed_in?
      @new_visited = Visited.new
      @new_visited.user_id = current_user.id
      @new_visited.story_id = story_visited.id
      # 古い閲覧履歴があるか？
      story_already_visited?
      @new_visited.save
      # 閲覧履歴が10件を超えたか？
      visited_stories_over_ten_pages?
    end
  end

  # ユーザーが表示したストーリーページがすでにVisitedモデルにの履歴ある場合
  # 古い閲覧履歴を削除
  def story_already_visited?
    if Visited.exists?(story_id: "#{params[:id]}")
      @old_visited = Visited.find_by(story_id: "#{params[:id]}")
      @old_visited.destroy
    end
  end

  # 閲覧履歴が10件を超えた場合、古い閲覧履歴を削除
  def visited_stories_over_ten_pages?
    @visited_stories = current_user.visiteds.reverse
    if @visited_stories.count > 10
      @visited_stories[9].destroy
    end
  end

  def auth_admin
    if user_signed_in?
      if current_user.admin == false
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
