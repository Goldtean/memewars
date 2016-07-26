App.messages = App.cable.subscriptions.create('VotesChannel', {  
  received: function(data) {
    $("#votes").removeClass('hidden')
    return $('#votes').append(this.renderVotes(data));
  },
  renderVotes: function(data) {
    return "<p> <b>" + data.user + ": </b>" + data.meme + "</p>";
  }
});