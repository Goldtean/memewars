$(document).ready(function() {
  submitViaEnter();
  submitViaSend();
});

function submitViaEnter() {
  $('textarea#message_content').keydown(function(event) {
    if (event.keyCode == 13) {
      $('[data-send="message"]').click();
      $('[data-textarea="message"]').val(" ")
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