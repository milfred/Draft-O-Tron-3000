// $(function() {
//
//   $(".search-form").on("submit", function(event) {
//     event.preventDefault();
//   });
//
//   $(".search-setting").change(function() {
//     if ($(this).val() === "update") {
//       $("#status-container").removeClass("hide");
//     } else if ($(this).val() === "find") {
//       $("#status-container").addClass("hide");
//     }
//   });
//
//   $(".search-field").on("keyup", function() {
//     var searchField = $(this);
//     var playerName = searchField.val();
//     var url = $(".search-form").attr("action");
//     var data = "search=" + playerName;
//
//     if(playerName.length >= 3) {
//       var request = $.ajax({
//         url: url,
//         method: "GET",
//         data: data
//       });
//
//       request.done(function(response) {
//         var fadeDelay = 0;
//         $("#search-results").html("");
//
//         if(response.length > 0) {
//           $.each(response, function(index, player) {
//             $("<li><a class='white' href='#" + player.id + "'>" + player.name + " " + player.position + " " + player.team + "</a></li>").hide().appendTo("#search-results").delay(fadeDelay).fadeIn(100);
//             fadeDelay += 50;
//           });
//         } else {
//           $("<li class='white'>No results found</li>").hide().appendTo("#search-results").fadeIn(100);
//         }
//       });
//     } else {
//       $("#search-results").html("");
//     }
//   });
//
// });



$(function() {

  // Prevent the default action for a search submission
  $(".search-form").on("submit", function(event) {
    event.preventDefault();
  });

  // Display update options if update is selected
  $(".search-setting").change(function() {
    if ($(this).val() === "update") {
      $("#status-container").removeClass("hide");
    } else if ($(this).val() === "find") {
      $("#status-container").addClass("hide");
    }
  });


  $(".search-field").on("keyup", function() {
    var searchField = $(this);
    var keyword = searchField.val();
    var url = $(".search-form").attr("action");
    var data = "search=" + keyword;
    var currentResults = $("#search-results a").map(function(index, link) {
      var linkId = $(link).attr("href");
      return parseInt(linkId.substring(1, linkId.length));
    });

    if(keyword.length >= 3) {
      var request = $.ajax({
        url: url,
        method: "GET",
        data: data
      });

      request.done(function(response) {

        var newResults = $.map(response, function(index) {
          return index.id;
        });

        var resultsToRemove = $.makeArray(currentResults).filter(function(val) {
          return $.makeArray(newResults).indexOf(val) == -1;
        });
        var resultsToAdd = $.makeArray(newResults).filter(function(val) {
          return $.makeArray(currentResults).indexOf(val) == -1;
        });

        if(response.length > 0) {
          var fadeDelay = 0;
          removeResults(resultsToRemove);
          addResults(resultsToAdd, response);
        } else {
          $("#search-results").html("");
          $("<li class='no-results white'>No results found</li>").hide().appendTo("#search-results").fadeIn(200);
        }
      });
    } else {
      $("#search-results").html("");
    }
  });

});


function removeResults(removeArray) {
  var fadeDelay = 0;
  if (removeArray.length > 0) {
    $.each(removeArray, function(index, playerId) {
      $("#search-results a[href='#"  + playerId + "']").closest("li").delay(fadeDelay).fadeOut(100, function() {
        $(this).remove();
      });
      fadeDelay += 50;
    });
  }
}
function addResults(addArray, response) {
  var fadeDelay = 0;
  if (addArray.length > 0) {
    $(".no-results").remove();
    $.each(response, function(index, player) {
      if (addArray.includes(player.id)) {
        $("<li><a class='white' href='#" + player.id + "'>" + player.name + " " + player.position + " " + player.team + "</a></li>").hide().appendTo("#search-results").delay(fadeDelay).fadeIn(100);
        fadeDelay += 50;
      }
    });
  }
}
