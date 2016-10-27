class ChatroomPlayersController < ApplicationController

  def update
    @player = ChatroomPlayer.find(params[:id])
    if @player.status == "ready"
      @player.status = "unready"
    else
      @player.status = "ready"
    end
    if @player.save!
      @slug = Chatroom.find(@player.chatroom_id)
      ActionCable.server.broadcast "chatrooms_#{@slug.slug}",
        username: current_user.username,
        status: @player.status
      head :ok
      return
    end
  end

  private

    def player_params
      # params.require(:message).permit(:content, :chatroom_id)
    end
end