$(document).ready(function() {
  submitViaEnter();
  submitViaSend();
  captionSubmission();
  readySend();
  unreadySend();
  leaveGame();
});

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

function captionSubmission() {
  $('[data-send="meme"]').on('click', function(event){
    event.preventDefault();
    $('[data-send="meme"]').submit();
    $('#new_meme').hide();
    // $('#new_meme').submit();
  });
}

function readySend() {
  $('[data-send="ready"]').on('click', function(event) {
    event.preventDefault();
    $('[data-send="ready"]').submit();
    $("#unready-button").removeClass('hidden');
    $("#ready-button").addClass('hidden');
  });
}

function unreadySend() {
  $('[data-send="unready"]').on('click', function(event) {
    event.preventDefault();
    $('[data-send="unready"]').submit();
    $("#ready-button").removeClass('hidden');
    $("#unready-button").addClass('hidden');
  });
}

function leaveGame() {
  $('[data-send="leave"]').on('click', function(event){
    event.preventDefault();
    $('[data-send="leave"]').submit();
    window.location.replace("/");
  });
}