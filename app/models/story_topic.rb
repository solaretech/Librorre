class StoryTopic < ApplicationRecord
  has_many :story_bodies
  belongs_to :story

  accepts_nested_attributes_for :story_bodies, allow_destroy: true
end
