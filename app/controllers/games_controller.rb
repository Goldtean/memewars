# class GamesController < ApplicationController

#   def index
#     @game = Game.new
#     @games = Game.all
#   end

#   def new
#     @picture = Picture.new
#     @chatroom = Chatroom.new
#     @game = Game.new
#   end

#   def create
#     @picture = Picture.new
#     @chatroom = Chatroom.new
#     if @picture.save && @chatroom.save
#       @game = Game.new(user: current_user, chatroom: @chatroom, picture: @picture)
#       if @game.save
#         redirect_to @game
#     end
#     # message = Message.new(message_params)
#     # message.user = current_user
#     # if message.save
#     #   ActionCable.server.broadcast 'messages',
#     #     message: message.content,
#     #     user: message.user.username
#     #   head :ok
#     # end
#   end

#   private

#     def game_params
#       # params.require(:message).permit(:content, :chatroom_id)
#     end
# end
