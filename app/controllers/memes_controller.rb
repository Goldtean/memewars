class MemesController < ApplicationController

  def create
    meme = Meme.new(meme_params)
      if meme.save!
        @chatroom_picture = ChatroomPicture.find(meme.chatroom_picture_id)
        @chatroom = Chatroom.find(@chatroom_picture.chatroom_id)
        @slug = @chatroom.slug
        ActionCable.server.broadcast "memes_#{@slug}",
          meme_status: "Meme"
        head :ok
      end
  end

  private

    def meme_params
      params.require(:meme).permit(:caption, :chatroom_player_id, :chatroom_picture_id)
    end
end
