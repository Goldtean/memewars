class ChatroomPlayersController < ApplicationController

  def destroy
    @player = ChatroomPlayer.find(params[:id])
    if @player.destroy!
      @slug = Chatroom.find(@player.chatroom_id)
      ActionCable.server.broadcast "chatrooms_#{@slug.slug}",
        username: current_user.username,
        status: "left"
      head :ok
      return
    end
  end

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

  def addarnold
    @slug = params[:slug].to_s
    @arnoldcount = params[:arnoldcount].to_i
    if @arnoldcount < 1
      @chatroom_player = ChatroomPlayer.new
      @chatroom_player.user_id = User.find_by(username: "Arnold").id
      @chatroom_player.chatroom_id = Chatroom.find_by(slug: params[:slug]).id
      @chatroom_player.playername = "Arnold"
      @chatroom_player.status = "ready"
      if @chatroom_player.save!
        ActionCable.server.broadcast "chatrooms_#{@slug}",
          username: "Arnold",
          status: "addarnold"
        head :ok
        return
      end
    end
    if @arnoldcount < 2
      @chatroom_player = ChatroomPlayer.new
      @chatroom_player.user_id = User.find_by(username: "Schwarzenegger").id
      @chatroom_player.chatroom_id = Chatroom.find_by(slug: params[:slug]).id
      @chatroom_player.playername = "Schwarzenegger"
      @chatroom_player.status = "ready"
      if @chatroom_player.save!
        ActionCable.server.broadcast "chatrooms_#{@slug}",
          username: "Schwarzenegger",
          status: "addarnold"
        head :ok
        return
      end
    end
  end

  def removearnold
    # Remove Arnold
    @chatroom = Chatroom.find_by(slug: params[:slug].to_s)
    @chatroom_player = ChatroomPlayer.where(chatroom: @chatroom, playername: "Arnold").first || ChatroomPlayer.where(chatroom: @chatroom, playername: "Schwarzenegger").first
    if @chatroom_player.destroy!
        ActionCable.server.broadcast "chatrooms_#{@chatroom.slug}",
          username: "#{@chatroom_player.playername}",
          status: "left"
        head :ok
        return
      end
  end

  private

    def player_params
      params.require(:chatroom_player).permit(:status, :arnoldcount)
    end
end