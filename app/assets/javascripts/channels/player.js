$(document).ready(function() {
  chatroomSlug = $('#chatroom-slug').text();
  App.player = App.cable.subscriptions.create({channel: 'ChatroomsChannel', slug: chatroomSlug}, {  
    received: function(data) {

      // Real Time Add And Remove Player From Ready List
      $("#ready-players").removeClass('hidden');
      if (data.status == "new") {
        return $('#joined-players').append(this.renderJoined(data));
      } else if (data.status == "left") {
        $('#'+ data.username).remove();
        return $('#player-'+ data.username).remove();
      } else if (data.status == "ready") {
        return $('#ready-players').append(this.renderReady(data));
      } else if (data.status == "unready") {
        return $('#'+ data.username).remove();
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