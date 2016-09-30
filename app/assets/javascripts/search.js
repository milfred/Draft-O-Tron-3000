$(function() {

  $(".search-field").on("keyup", function() {
    var searchField = $(this);
    var playerName = searchField.val();
    var data = "search=" + playerName;

    if(playerName.length > 3) {
      var request = $.ajax({
        url: "/search",
        method: "GET",
        data: data
      });

      request.done(function(response) {
        $.each(response, function(index, player) {
          console.log(player.name);
        });
      });
    }
  });

});
