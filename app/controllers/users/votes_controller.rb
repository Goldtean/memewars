class VotesController < ApplicationController

  def create
    vote = Vote.new(vote_params)
    vote.user_id = current_user.id
    if vote.save
      ActionCable.server.broadcast 'votes',
        vote: vote.meme_id
      head :ok
    end
  end

  private

    def vote_params
      params.require(:message).permit(:content, :chatroom_id)
    end

end