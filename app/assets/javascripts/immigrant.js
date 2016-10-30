// $(document).ready(function() {
//   joinedPlayerCount();
//   readyPlayerCount();
// });


// var joinedPlayerCount = function() {
//   numberOfJoinedPlayers = $("#joined-players p").length;
//   $('#chatroom-slug').numberOfJoinedPlayers = $("#joined-players p").length;
// }
// var readyPlayerCount = function() {
//   numberOfReadyPlayers = $("#ready-players p").length;
// }

// var advanceGameToMemeing = function() {
//   if (numberOfReadyPlayers > 2) {
//     if (numberOfReadyPlayers == numberOfJoinedPlayers) {
//       window.location.replace("/" + $('#chatroom-slug') + "/meme");
//     }
//   }
// }

var checkChatroomReadyStatus = function() {
  if ($("#ready-players p").length > 2 && $("#ready-players p").length == $("#joined-players p").length) {
    url = "/" + $('#chatroom-slug').text() + "/meme";
    window.location.replace(url);
  }
}