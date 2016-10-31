class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :chatroom_player
  validates :content, presence: true, length: {minimum: 2, maximum: 200}
end