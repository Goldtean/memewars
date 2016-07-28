class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
  validates :content, presence: true, length: {minimum: 2, maximum: 200}
end