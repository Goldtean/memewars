$(document).ready(function() {
  chatroomSlug = $('#chatroom-slug').text();
  App.memes = App.cable.subscriptions.create({channel: 'MemesChannel', slug: chatroomSlug}, {  
    received: function(data) {
      if (data.meme_status == "Vote") {
        console.log("Voted good and easy");
        var votesLeftToSubmit = parseInt($('#votes-left-to-submit').text());
        $('#votes-left-to-submit').text(votesLeftToSubmit - 1);
        return checkVoteSubmissionStatus();
      } else if (data.meme_status == "Meme") {
        var memesLeftToSubmit = parseInt($('#memes-left-to-submit').text());
        $('#memes-left-to-submit').text(memesLeftToSubmit - 1);
        return checkMemeSubmissionStatus();
      }
      
    }
  });
})