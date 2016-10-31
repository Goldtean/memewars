class Vote < ApplicationRecord
  belongs_to :meme
  belongs_to :chatroom_player
end