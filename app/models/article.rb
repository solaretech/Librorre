class Article < ApplicationRecord
  has_many :article_categories
  has_many :stories
  has_many :artist_histories
end
