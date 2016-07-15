class ChatroomPicture < ApplicationRecord
  belongs_to :picture
  belongs_to :chatroom
end
