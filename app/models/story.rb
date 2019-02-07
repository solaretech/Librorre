class Story < ApplicationRecord
  has_many :libraries

  has_many :story_categories, dependent: :destroy
  has_many :categories, through: :story_categories
  has_many :story_topics

  accepts_nested_attributes_for :story_topics, allow_destroy: true

  belongs_to :user

end
