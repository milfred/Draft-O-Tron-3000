$(function() {

  $(".search-form").on("submit", function(event) {
    event.preventDefault();
  });

  $(".search-field").on("keyup", function() {
    var searchField = $(this);
    var playerName = searchField.val();
    var url = searchField.attr("action");
    var data = "search=" + playerName;
    var setting = $(".search-setting").val();

    if(playerName.length >= 3) {
      var request = $.ajax({
        url: url,
        method: "GET",
        data: data
      });

      request.done(function(response) {
        console.log(response);
        var fadeDelay = 0;
        $("#search-results").html("");

        $.each(response, function(index, player) {
          $("<li><a href='#" + player.id + "'>" + player.name + " " + player.position + " " + player.team + "</a></li>").hide().appendTo("#search-results").delay(fadeDelay).fadeIn(100);
          fadeDelay += 50;
        });
      });
    } else {
      $("#search-results").html("");
    }
  });

});
