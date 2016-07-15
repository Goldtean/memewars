class MemesController < ApplicationController

  def create
    meme = Meme.new(meme_params)
    meme.user = current_user
      if meme.save!
        # render "chatrooms/#{}"
        # format.html { render 'chatrooms/', notice: 'picture was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @picture }
      else
        format.html { render action: 'new' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    # if meme.save!
    #   ActionCable.server.broadcast 'meme',
    #     meme: meme.caption,
    #   head :ok
    # end
  end

  private

    def meme_params
      params.require(:meme).permit(:caption, :chatroom_id, :user_id, :picture_id)
    end
end
