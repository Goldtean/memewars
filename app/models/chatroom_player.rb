class ChatroomPlayer < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
end
