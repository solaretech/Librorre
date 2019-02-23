class Message < ApplicationRecord
  default_scope -> {order(created_at: :asc)}

  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"

  validates :from_id, presence: true
  validates :to_id, presence: true
  validates :room_id, presence: true
  validates :content, presence: true, length: {maximum: 50}

  def Message.recent_in_room(room_id)
    where(room_id: room_id).last(50)
  end
end
