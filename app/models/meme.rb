class Meme < ApplicationRecord
  belongs_to :chatroom_player
  belongs_to :chatroom_picture
  has_many :votes
  has_many :voters,
    through: :votes,
    source: :chatroom_player,
    class_name: "ChatroomPlayer"

end