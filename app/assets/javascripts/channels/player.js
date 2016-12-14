$(document).ready(function() {
  chatroomSlug = $('#chatroom-slug').text();
  App.player = App.cable.subscriptions.create({channel: 'ChatroomsChannel', slug: chatroomSlug}, {  
    received: function(data) {

      // Real Time Add And Remove Player From Ready List
      $("#ready-players").removeClass('hidden');
      if (data.status == "new") {
        // numberOfJoinedPlayers++;
        return $('#joined-players').append(this.renderJoined(data));
      } else if (data.status == "left") {
        // numberOfJoinedPlayers = numberOfJoinedPlayers - 1;
        $('#'+ data.username).remove();
        $('#player-'+ data.username).remove();
        return false
      } else if (data.status == "ready") {
        // numberOfReadyPlayers++;
        $('#ready-players').append(this.renderReady(data));
        return checkChatroomReadyStatus();
      } else if (data.status == "unready") {
        // numberOfReadyPlayers = numberOfReadyPlayers - 1;
        return $('#'+ data.username).remove();
      } else if (data.status == "addarnold") {
        // numberOfReadyPlayers++;
        $('#ready-players').append(this.renderReady(data));
        // numberOfJoinedPlayers++;
        $('#joined-players').append(this.renderJoined(data));
        return checkChatroomReadyStatus();
      };
    },
    renderReady: function(data) {
      return "<p id='" + data.username + "' >" + data.username + "</p>";
    },
    renderJoined: function(data) {
      return "<p id='player-" + data.username + "' >" + data.username + "</p>"
    }
  });
})