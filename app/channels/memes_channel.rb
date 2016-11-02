class MemesChannel < ApplicationCable::Channel  
  def subscribed
    stream_from "memes_#{params['slug']}"
  end
end  
