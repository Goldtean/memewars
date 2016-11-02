// Action Cable Slaves
var checkChatroomReadyStatus = function() {
  if ($("#ready-players p").length > 2 && $("#ready-players p").length == $("#joined-players p").length) {
    url = "/" + $('#chatroom-slug').text() + "/meme";
    window.location.replace(url);
  }
}

var checkMemeSubmissionStatus = function() {
  if (parseInt($('#memes-left-to-submit').text()) == 0) {
    url = "/" + $('#chatroom-slug').text() + "/vote";
    window.location.replace(url);
  }
}

var checkVoteSubmissionStatus = function() {
  if (parseInt($('#votes-left-to-submit').text()) == 0) {
    url = "/" + $('#chatroom-slug').text() + "/winner";
    window.location.replace(url);
  }
}