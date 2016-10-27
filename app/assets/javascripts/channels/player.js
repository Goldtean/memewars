$(document).ready(function() {
  chatroomSlug = $('#chatroom-slug').text();
  App.player = App.cable.subscriptions.create({channel: 'ChatroomsChannel', slug: chatroomSlug}, {  
    received: function(data) {
      $("#ready-players").removeClass('hidden');
      if (data.status == "ready") {
        return $('#ready-players').append(this.renderMessage(data));
      } else if (data.status == "unready") {
        return $('#'+ data.username).remove();
      }
    },
    renderMessage: function(data) {
      return "<p id='" + data.username + "' >" + data.username + "</p>";
    }
  });

})