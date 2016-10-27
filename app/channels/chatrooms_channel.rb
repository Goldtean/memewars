class ChatroomsChannel < ApplicationCable::Channel  
  def subscribed
    stream_from "chatrooms_#{params['slug']}"
  end
end  
