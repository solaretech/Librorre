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

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
