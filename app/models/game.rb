class Game < ApplicationRecord
  has_one :chatroom
  has_many :players, class_name: 'User', foreign_key: 'player_id'
  has_many :pictures
  
end