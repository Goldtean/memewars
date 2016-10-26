class ChatroomsChannel < ApplicationCable::Channel  
  def subscribed
    stream_from "chatrooms_#{params['chatroom_id']}_channel"
  end
end  
