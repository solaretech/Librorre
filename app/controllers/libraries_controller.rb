class LibrariesController < ApplicationController
  def index
    @libraries = current_user.libraries.page(params[:page]).per(10)
    @stories = current_user.stories.page(params[:page]).per(10)
  end

  def create
    story = Story.find(params[:story_id])
    library = current_user.libraries.new(story_id: story.id)
    library.save
    respond_to do |format|
      format.html { redirect_to @story }
      format.js
    end
  end

  def destroy
    story = Story.find(params[:story_id])
    library = current_user.libraries.find_by(story_id: story.id)
    library.destroy
    respond_to do |format|
     format.html { redirect_to @story }
     format.js
    end
  end
end
