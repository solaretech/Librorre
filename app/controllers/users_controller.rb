class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:update, :unsubscribe]
  before_action :auth_admin, only: [:index]
  before_action :unsubscribed_user?, only: [:top]

  def top
    @article = Article.new
    @articles = Article.page(params[:page]).per(10)
    @stories = Story.page(params[:page]).per(10)
  end

  def about
  end

  def show
    @user = User.find(params[:id])
    @libraries = @user.libraries.count
    @visiteds = @user.visiteds.reverse
  end

  def index
    @users = User.search(params[:search])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def unsubscribe
    @user = User.find(params[:id])
    @user.deleted_user = true
    @user.save
    if @user == current_user
      reset_session
    end
    redirect_to root_path
  end

  def unsubscribed_user?
    if user_signed_in?
      if current_user.deleted_user == true
        reset_session
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end

end
