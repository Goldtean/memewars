class VotesController < ApplicationController

  def create
    vote = Vote.new(vote_params)
    vote.user = current_user
      if vote.save!
        # render "chatrooms/#{}"
        # format.html { render 'chatrooms/', notice: 'picture was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @picture }
      else
        format.html { render action: 'new' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    # if vote.save!
    #   ActionCable.server.broadcast 'vote',
    #     vote: vote.caption,
    #   head :ok
    # end
  end

  private

    def vote_params
      params.require(:vote).permit(:meme_id, :user_id)
    end
end
