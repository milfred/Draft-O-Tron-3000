$(function() {

  $("#scoring-data").submit(function(event) {
    event.preventDefault();
    console.log($(this).serialize());
  });

  $(".player-stats").on("click", function(event) {
    event.preventDefault();

    $(".stats-container").remove();
    var $player = $(this);
    var playerId = $(this).attr("id");

    console.log(playerId);

    var request = $.ajax({
      url: "/measurables/show",
      method: "GET",
      data: "player_id=" + playerId
    });

    request.done(function(response) {
      console.log(response);
      $player.after(response);
    });
  });

  $(window).click(function() {
    $(".stats-container").remove();
  });
});