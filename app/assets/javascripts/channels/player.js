$(document).ready(function() {

  App.player = App.cable.subscriptions.create({channel: 'ChatroomsChannel', chatroom_id: chatroomId}, {  
    received: function(data) {
      $("#players").removeClass('hidden');
      return $('#messages').append(this.renderMessage(data));
    },
    chatroom_id: function(data) {
      return data.chatroom_id
    },
    renderMessage: function(data) {
      return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
    }
  });

})
