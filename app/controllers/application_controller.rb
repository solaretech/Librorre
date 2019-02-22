class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create_article_history(old_article)
    @new_history = ArticleHistory.new
    @new_history.article_id = old_article.id
    @new_history.user_id = current_user.id
    @new_history.title = old_article.title
    @new_history.mean = old_article.mean
    @new_history.cause = old_article.cause
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

  # 作成者・管理者以外のアクセスを制限
  # User#update
  def ensure_authority
    unless params[:id] == current_user.id
      unless current_user.admin = true
        redirect_to user_path(current_user), alert: '許可されないリクエストです。'
      end
    end
  end

  # 管理者ログイン認証
  def auth_admin
    if user_signed_in?
      user = User.find(current_user.id)
      if user.admin == false
        redirect_to root_path, alert: '許可されていないリクエストです。'
      end
    else
      redirect_to root_path, alert: '許可されていないリクエストです。'
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
