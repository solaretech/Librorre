class Category < ApplicationRecord
  validates :name,presence:true,length:{maximum:50}

  has_many :articles_categories, dependent: :destroy
  has_many :articles, through: :articles_categories

  has_many :story_categories, dependent: :destroy
  has_many :stories, through: :story_categories
end
