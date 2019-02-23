class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :article_histories, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :story_comments, dependent: :destroy
  has_many :article_comments, dependent: :destroy
  has_many :libraries, dependent: :destroy
  has_many :visiteds, dependent: :destroy

  has_many :from_messages, class_name: "Message",foreign_key: "from_id", dependent: :destroy
  has_many :to_messages, class_name: "Message",foreign_key: "to_id", dependent: :destroy
  has_many :sent_messages, through: :from_messages, source: :from
  has_many :received_messages, through: :to_messages, source: :to

  validates :name, presence: true, length:{maximum: 20}
  validates :email, presence: true, length:{maximum: 50}
  validates :caption, length:{maximum: 140}

  attachment :image

  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  def send_message(other_user, room_id, comment)
    from_messages.create!(to_id: other_user.id, room_id: room_id, comment: comment)
  end

  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
    end
  end

end
