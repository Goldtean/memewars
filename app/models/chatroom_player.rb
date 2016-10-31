class ChatroomPlayer < ApplicationRecord
  # ChatroomPlayer has many Votes, has Memes through votes
  has_many :votes
  has_many :memes, through: :votes
  # ChatroomPlayer has many Memes, has Pictures through Memes
  has_many :memes, dependent: :destroy
  has_many :pictures, through: :memes
    # ChatroomPlayer has many messages, has Chatrooms through Messages
  has_many :messages, dependent: :destroy
  has_many :chatrooms, through: :messages
  # ChatroomPlayer belongs to User & Chatroom
  belongs_to :chatroom
  belongs_to :user


end
