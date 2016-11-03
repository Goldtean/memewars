class WelcomeController < ApplicationController

  def about
    @chatroom = Chatroom.new
  end
  
end