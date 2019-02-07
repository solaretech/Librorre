class UsersController < ApplicationController
  def top
  end

  def about
  end

  def show
    @user = User.find(params[:id])
    @libraries = @user.libraries.count
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
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end

end
