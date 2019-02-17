class StoryCommentsController < ApplicationController
  def create
    @story = Story.find(params[:story_id])
    story_comment = @story.story_comments.new(story_comment_params)
    story_comment.user_id = current_user.id
    story_comment.save
    @story_comments = @story.story_comments.reverse
  end

  def destroy
    story_comment = StoryComment.find(params[:id])
    @story = Story.find(story_comment.story_id)
    story_comment.destroy
    @story_comments = @story.story_comments.reverse
  end

  private

  def story_comment_params
    params.require(:story_comment).permit(:story_id, :user_id, :comment)
  end

end
