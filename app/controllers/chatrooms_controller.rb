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
    if Chatroom.find_by(slug: params[:slug].upcase)
      @chatroom = Chatroom.find_by(slug: params[:slug].upcase)
      redirect_to "/#{@chatroom.slug}"
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
        format.html { redirect_to "/#{@chatroom.slug}" }
        format.js { redirect_to "/#{@chatroom.slug}" }
      end
    else
      respond_to do |format|
        flash[:notice] = {error: ["A chatroom with this topic already exists"]}
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

  def waiting
    @chatroom = Chatroom.find_by(slug: params[:slug])
    @message = Message.new
    # Register Player To Game
    @current_player = ChatroomPlayer.where(user_id: current_user.id, chatroom_id: @chatroom.id)
    if @current_player.length > 0
      @chatroom_player = @current_player[0]
      else
      @chatroom_player = ChatroomPlayer.new
      @chatroom_player.user_id = current_user.id
      @chatroom_player.chatroom_id = @chatroom.id
      @chatroom_player.status = "new"
      if @chatroom_player.save!
      # Establish Readiness In Case Of New Player
      @players = ChatroomPlayer.where(chatroom_id: @chatroom.id)
      @ready_players = ChatroomPlayer.where(chatroom_id: @chatroom.id, status: "ready")
      # Shout it from the rooftops
        flash[:notice] = "Successfully joined game"
        ActionCable.server.broadcast "chatrooms_#{@chatroom.slug}",
          username: current_user.username,
          status: @chatroom_player.status
      return
      end
    end
    # Establish Readiness In Case Of Existing Player
    @players = ChatroomPlayer.where(chatroom_id: @chatroom.id)
    @ready_players = ChatroomPlayer.where(chatroom_id: @chatroom.id, status: "ready")
  end

  def show
    @vote = Vote.new
    @meme = Meme.new
    @picture = Picture.new
    @chatroom = Chatroom.find_by(slug: params[:slug].upcase)
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
    if @chatroom.pictures.length == 0
      redirect_to "/#{@chatroom.slug}/waiting"
      return
    end
    @message = Message.new
  end

  private

    def chatroom_params
      params.require(:chatroom).permit(:topic)
    end
end
