class ChatroomsController < ApplicationController

  def index
    @chatroom = Chatroom.new
    @chatrooms = Chatroom.all
  end

  def new
    if request.referrer.split("/").last == "chatrooms"
      flash[:notice] = nil
    end
    @chatroom = Chatroom.new
  end

  def edit
    @chatroom = Chatroom.find_by(slug: params[:slug])
  end

  def join
    if Chatroom.find_by(slug: params[:slug])
      puts " $$$$$$$$$$$$$$$" + params[:slug] + "$$$$$$$$$$$$$$$$" 
      @chatroom = Chatroom.find_by(slug: params[:slug])
      redirect_to "/#{params[:slug]}"
      return
    else
      respond_to do |format|
        flash[:notice] = {error: ["That game does not exist. Please try again."]}
        format.html { redirect_to :back}
        format.js { render template: 'chatrooms/chatroom_error.js.erb'} 
      end
    end
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      respond_to do |format|
        format.html { redirect_to @chatroom }
        format.js { redirect_to @chatroom }
      end
    else
      respond_to do |format|
        flash[:notice] = {error: ["a chatroom with this topic already exists"]}
        format.html { redirect_to new_chatroom_path }
        format.js { render template: 'chatrooms/chatroom_error.js.erb'} 
      end
    end
  end

  def update
    chatroom = Chatroom.find_by(slug: params[:slug])
    chatroom.update(chatroom_params)
    redirect_to chatroom
  end

  def show
    @vote = Vote.new
    @meme = Meme.new
    @picture = Picture.new
    @chatroom = Chatroom.find_by(slug: params[:slug])
    @chatroom_messages = Chatroom.includes(:messages).find_by(id: params[:id])
    if @current_picture
      @current_picture
      @current_meme = @current_picture.memes.where(user: current_user)
      if @current_picture.memes
        @memes = @current_picture.memes
      end
    else
      if @chatroom.pictures.length > 0
        @current_picture = Picture.find_by(id: @chatroom.chatroom_pictures.where('winner' == 'null').first.picture_id)
        if @current_picture.memes
          @memes = @current_picture.memes
          @current_meme = @current_picture.memes.where(user: current_user)
        end
      end
    end
    

    @message = Message.new
  end

  private

    def chatroom_params
      params.require(:chatroom).permit(:topic)
    end
end
