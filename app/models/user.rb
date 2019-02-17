class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :article_histories, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :libraries, dependent: :destroy
  has_many :visiteds, dependent: :destroy

  attachment :image
end
