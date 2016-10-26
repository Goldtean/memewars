class ChatroomPlayersController < ApplicationController
  def ready
    # chatroom = Chatroom.find_by(slug: params[:slug])
    # playerarray = ChatroomPlayer.where(user_id: current_user.id, chatroom_id: chatroom.id)
    # player = playerarray[0]
    # player.status = "ready"
    # if player.save!
    #   ActionCable.server.broadcast "chatrooms_#{chatroom.id}_channel",
    #     new_player_ready: player.id
    #   head :ok
    # end
    # message.user = current_user
    # if message.save
    #   ActionCable.server.broadcast "messages_#{message.chatroom_id}_channel",
    #     message: message.content,
    #     user: message.user.username
    #   head :ok
    # end
  end

  private

    def player_params
      # params.require(:message).permit(:content, :chatroom_id)
    end
end