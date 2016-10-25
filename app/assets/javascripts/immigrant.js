$(document).ready(function() {
  increaseCount();
  checkPlayersReady();
});


var playerCount = 0;

var readyPlayers = 0;

var increaseCount = function() {
  playerCount = playerCount + parseInt($('#players-count-hidden').text());
};


var checkPlayersReady = function() {

};