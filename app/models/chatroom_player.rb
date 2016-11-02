class ChatroomPlayer < ApplicationRecord
  # ChatroomPlayer has many Votes, has Memes through votes
  has_many :votes
  has_many :voted_for_memes,
    through: :votes,
    source: :memes,
    class_name: "Meme"
  # ChatroomPlayer has many Memes, has Pictures through Memes
  has_many :memes, dependent: :destroy
  has_many :chatroom_pictures, through: :memes
    # ChatroomPlayer has many messages, has Chatrooms through Messages
  has_many :messages, dependent: :destroy
  has_many :chatrooms, through: :messages
  # ChatroomPlayer belongs to User & Chatroom
  belongs_to :chatroom
  belongs_to :user


end
