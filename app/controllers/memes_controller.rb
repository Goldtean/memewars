class MemesController < ApplicationController

  def create
    meme = Meme.new(meme_params)
    meme.user = current_user
      if meme.save
        ActionCable.server.broadcast 'memes',
          caption: meme.caption
        head :ok
      else
        format.html { render action: 'new' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
  end

  private

    def meme_params
      params.require(:meme).permit(:caption, :chatroom_id, :user_id, :picture_id)
    end
end
