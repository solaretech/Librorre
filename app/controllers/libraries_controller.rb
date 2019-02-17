class LibrariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @libraries = current_user.libraries.page(params[:page]).per(10)
    @stories = current_user.stories.page(params[:page]).per(10)
  end

  def create
    @story = Story.find(params[:story_id])
    library = current_user.libraries.new(story_id: @story.id)
    library.save
  end

  def destroy
    @story = Story.find(params[:story_id])
    library = current_user.libraries.find_by(story_id: @story.id)
    library.destroy
  end
end
