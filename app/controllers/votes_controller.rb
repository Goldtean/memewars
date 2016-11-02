class VotesController < ApplicationController

  def create
    vote = Vote.new(vote_params)
      if vote.save!
        @chatroom_picture = ChatroomPicture.find(vote.meme.chatroom_picture_id)
        @chatroom = Chatroom.find(@chatroom_picture.chatroom_id)
        @slug = @chatroom.slug
        ActionCable.server.broadcast "memes_#{@slug}",
          meme_status: "Vote"
        head :ok
      end
  end

  private

    def vote_params
      params.require(:vote).permit(:meme_id, :chatroom_player_id)
    end
end
