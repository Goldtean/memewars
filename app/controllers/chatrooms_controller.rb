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
    if @chatroom.save!
      offset = rand(Picture.count)
      rando_picrissian = Picture.offset(offset).first
      @chatroom_picture = ChatroomPicture.new(chatroom: @chatroom, picture: rando_picrissian)
      if @chatroom_picture.save!
        respond_to do |format|
          format.html { redirect_to "/#{@chatroom.slug}" }
          format.js { redirect_to "/#{@chatroom.slug}" }
        end
      end
    else
      respond_to do |format|
        flash[:notice] = {error: ["A game with this topic already exists"]}
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
      @chatroom_player.playername = current_user.username
      @chatroom_player.status = "new"
      if @chatroom.players.length == 0
        @chatroom_player.creator = true
      end
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
    # New Picture If This Is Not A New Game
    if @chatroom_player.creator == true && ChatroomPicture.where(chatroom: @chatroom, winner: true).length == ChatroomPicture.where(chatroom: @chatroom).length
      offset = rand(Picture.count)
      rando_picrissian = Picture.offset(offset).first
      @new_chatroom_picture = ChatroomPicture.new(chatroom: @chatroom, picture: rando_picrissian)
      @new_chatroom_picture.save!
    end
    # Arnold
    if @chatroom_player.creator == true
      @arnolds = []
      @arnold = ChatroomPlayer.where(playername: "Arnold", chatroom: @chatroom).first
      @schwarzenegger = ChatroomPlayer.where(playername: "Schwarzenegger", chatroom: @chatroom).first
      if @arnold
        @arnolds << @arnold
      end
      if @schwarzenegger
        @arnolds << @schwarzenegger
      end
    end
  end

  def winner


    @chatroom = Chatroom.find_by(slug: params[:slug])
    @current_player = ChatroomPlayer.where(user_id: current_user.id, chatroom_id: @chatroom.id)
    @chatroom_player = @current_player[0]
    @chatroom_player.status = "unready"
    @chatroom_player.save!

    @chatroom_picture = ChatroomPicture.where(chatroom: @chatroom).last
    @memes = @chatroom_picture.memes

    meme_array = []
    @memes.each do |meme|
      if meme_array.length == 0
        meme_array << meme
      else
        if meme.votes.count > meme_array[0].votes.count
          meme_array.pop
          meme_array << meme
        end
      end
    end

    @winner = meme_array[0]
    if @chatroom_player.creator == true && @chatroom_picture.winner != true
      @winner.winner = true
      @winner.save!
      @chatroom_picture.winner = true
      @chatroom_picture.save!
    end

  end

  def meme
    @chatroom = Chatroom.find_by(slug: params[:slug])
    @current_player = ChatroomPlayer.where(user_id: current_user.id, chatroom_id: @chatroom.id)
    @chatroom_player = @current_player[0]
    @meme = Meme.new
    @message = Message.new
    @chatroom_picture = ChatroomPicture.where(chatroom: @chatroom).last
    if Meme.where(chatroom_player_id: @chatroom_player.id, chatroom_picture_id: @chatroom_picture.id).length < 1
       @chatroom_player_meme = "doesn't exist"
    end
    @ready_player_count = ChatroomPlayer.where(chatroom_id: @chatroom.id, status: "ready").length
    # Detect Arnold
    if @chatroom_player.creator == true
      @arnolds = []
      @arnold = ChatroomPlayer.where(playername: "Arnold", chatroom: @chatroom).first
      @schwarzenegger = ChatroomPlayer.where(playername: "Schwarzenegger", chatroom: @chatroom).first
      if @arnold
        @arnolds << @arnold
      end
      if @schwarzenegger
        @arnolds << @schwarzenegger
      end
      # Meme Arnold
      @arnolds.each do |arndawg|
        if Meme.where(chatroom_player_id: arndawg.id, chatroom_picture_id: @chatroom_picture.id).length < 1
          meme = Meme.new
          meme.caption = Arnold.quote
          meme.chatroom_player_id = arndawg.id
          meme.chatroom_picture_id = @chatroom_picture.id
          if meme.save!
            ActionCable.server.broadcast "memes_#{@chatroom.slug}",
              meme_status: "Meme"
          end
        end
      end
    end
    

  end

  def vote
    @vote = Vote.new
    @chatroom = Chatroom.find_by(slug: params[:slug])
    @current_player = ChatroomPlayer.where(user_id: current_user.id, chatroom_id: @chatroom.id)
    @chatroom_player = @current_player[0]
    @message = Message.new
    @chatroom_picture = ChatroomPicture.where(chatroom: @chatroom).last
    @memes = @chatroom_picture.memes
    @own_meme = @chatroom_picture.memes.where(chatroom_player_id: @chatroom_player.id).last
    @memes = @memes - [@own_meme]

        # Detect Arnold
    if @chatroom_player.creator == true
      @arnolds = []
      @arnold = ChatroomPlayer.where(playername: "Arnold", chatroom: @chatroom).first
      @schwarzenegger = ChatroomPlayer.where(playername: "Schwarzenegger", chatroom: @chatroom).first
      if @arnold
        @arnolds << @arnold
      end
      if @schwarzenegger
        @arnolds << @schwarzenegger
      end
      # Meme Arnold
      if @arnolds.length > 0

        @arnolds.each do |arndawg|
          vote_count = 0
          @memes.each do |meme|
            if Vote.where(meme_id: meme.id, chatroom_player_id: arndawg.id).length > 0
              vote_count += 1
              puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$" + vote_count + "PLAYERNAME:" + arndawg.playername + "$$$$$$$$$$$$$$" + "VOTING FOR:" + meme.caption
            end
          end
          if vote_count < 1
            vote = Vote.new
            vote.chatroom_player_id = arndawg.id
            eligible_votes = @chatroom_picture.memes.where.not(chatroom_player_id: arndawg.id)
            ev_rand = rand(eligible_votes.count)
            vote.meme_id = eligible_votes[ev_rand].id
            if vote.save!
              ActionCable.server.broadcast "memes_#{@chatroom.slug}",
                meme_status: "Vote"
            end
          end
        end

      end
    end
    @vote_count = 0
    @chatroom_picture.memes.each do |meme|
      @vote_count += meme.voters.length
    end
  end

  def show
    @chatroom = Chatroom.find_by(slug: params[:slug].upcase)
    if @chatroom.chatroom_pictures.length == 0 
      redirect_to "/#{@chatroom.slug}/waiting"
      return
    elsif @chatroom.pictures.length > 0
      if @chatroom.chatroom_pictures.last.memes.length > 2 && (@chatroom.chatroom_pictures.last.memes.length == @chatroom.chatroom_players.where(status: "ready").length)
        redirect_to "/#{@chatroom.slug}/vote"
        return
      elsif ((@chatroom.players.length > 2) && (@chatroom.chatroom_players.where(status: "ready").length == @chatroom.players.length))
        redirect_to "/#{@chatroom.slug}/meme"
        return
      end
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
