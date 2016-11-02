class ChatroomPicture < ApplicationRecord
  # ChatroomPictures have many Memes, ChatroomPlayers through Memes
  has_many :memes
  has_many :chatroom_players, through: :memes

  belongs_to :picture
  belongs_to :chatroom
end
