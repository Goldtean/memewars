App.memes = App.cable.subscriptions.create('MemesChannel', {  
  received: function(data) {
    $("#memes").removeClass('hidden')
    return $('#memes').append(this.renderMeme(data));
  },
  renderMeme: function(data) {
    return "<p>" + data.caption + "</p>";
  }
});