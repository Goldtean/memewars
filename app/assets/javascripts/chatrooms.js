$(document).ready(function() {
  // Chat
  submitViaEnter();
  submitViaSend();
  // Real Time caption
  captionSubmission();
  // Real Time Vote
  $('.vote-form').on('click', removeVoteButton);
  checkVoteSubmissionStatus();
  // Ready / Unready / Leave Game
  readySend();
  unreadySend();
  leaveGame();
});
// Chatroom Real Time Send / Receive
// Data via message_chatroom_id channel
function submitViaEnter() {
  $('textarea#message_content').keydown(function(event) {
    if (event.keyCode == 13) {
      $('[data-send="message"]').click();
      $('[data-textarea="message"]').val(" ");
      return false;
     }
  });
}

function submitViaSend() {
  $('[data-send="message"]').on('click', function(event) {
    event.preventDefault();
    $('[data-send="message"]').submit();
    $('textarea#message_content').val(" ");
    $('textarea#message_content').focus();
  });
}
// Caption Real Time Send
// Data via meme channel
function captionSubmission() {
  $('[data-send="meme"]').on('click', function(event){
    event.preventDefault();
    $('[data-send="meme"]').submit();
    $('#new_meme').remove();
  });
}
// Real Time Vote Send
// Data via meme channel
var removeVoteButton = function() {
  $('#vote-for-captions').hide();
}


// Real Time Ready, remove ready button, add unready button
// Data via chatroom_slug channel, receive via player.js
function readySend() {
  $('[data-send="ready"]').on('click', function(event) {
    event.preventDefault();
    $('[data-send="ready"]').submit();
    $("#unready-button").removeClass('hidden');
    $("#ready-button").addClass('hidden');
  });
}
// Real Time Unready, remove unready button, add ready button
// Data via chatroom_slug channel, receive via player.js
function unreadySend() {
  $('[data-send="unready"]').on('click', function(event) {
    event.preventDefault();
    $('[data-send="unready"]').submit();
    $("#ready-button").removeClass('hidden');
    $("#unready-button").addClass('hidden');
  });
}
// Real Time Leave
// Data via chatroom_slug channel, receive via player.js
function leaveGame() {
  $('[data-send="leave"]').on('click', function(event){
    event.preventDefault();
    $('[data-send="leave"]').submit();
    window.location.replace("/");
  });
}