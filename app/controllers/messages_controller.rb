class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    if message.save!
      ActionCable.server.broadcast "messages_#{message.chatroom_id}_channel",
        message: message.content,
        user: message.chatroom_player.playername
      head :ok
    end
  end

  private

    def message_params
      params.require(:message).permit(:content, :chatroom_id, :chatroom_player_id)
    end
end