$(function() {
  $(".scroll-to-top").hide();
  $(".drafted-players").hide();

  $(".player-status").change(function() {
    var $selectStatus = $(this);
    var statusValue = $selectStatus.val();
    var playerName = $selectStatus.closest("tr").find(".player-name");
    var rankingId = $selectStatus.attr("id");
    var statusLookup = {
      available: 0,
      targeted: 1,
      drafted: 2,
      unavailable: 3
    };
    var data = "status=" + statusLookup[statusValue];

    $selectStatus.closest("tr").removeClass("targeted-player drafted-player unavailable-player");

    if ($selectStatus.val() === "targeted") {
      $selectStatus.closest("tr").addClass("targeted-player");
    } else if ($selectStatus.val() === "drafted") {
      $selectStatus.closest("tr").addClass("drafted-player");
      $(".drafted-players #drafted-players-list").append("<li>" + playerName.find("a").text() + "</li>");
      $(".drafted-players").fadeIn(1000);
      $(".drafted-players").delay(3000).fadeOut(1000);
    } else if ($selectStatus.val() === "unavailable") {
      $selectStatus.closest("tr").addClass("unavailable-player");
    }

    var request = $.ajax({
      url: "/rankings/" + rankingId,
      method: "PATCH",
      data: data
    });

  });

  var $table = $('table.players');
  $table.floatThead();

  // Check to see if the window is top if not then display button
	$(window).scroll(function(){

		if ($(this).scrollTop() > 100) {
			$('.scroll-to-top').fadeIn();
		} else {
			$('.scroll-to-top').fadeOut();
		}
	});

	//Click event to scroll to top
	$(".scroll-to-top").click(function(){
		$("html, body").animate({scrollTop : 0},300);
		return false;
	});

  $("#sortable").sortable({
    containment: "parent",
    placeholder: "ui-sortable-placeholder",
    tolerance: 'pointer',
    update: function() {
      updateRank();
    },
    axis: "y",
    cursor: "move"
  });

  function updateRank() {
    $(".rank").each(function(index) {
      $(this).html(index + 1);
      var data = "player_rank=" + $(this).html();
      var rankingId = $(this).attr("id");

      var request = $.ajax({
        url: "/rankings/" + rankingId,
        method: "PATCH",
        data: data
      });
    });
  }

    $(".menu-button").on("click", function() {
      $("#scoring-data").css("right", "0");
      $(".menu-button").css("opacity", "0");
    });
    $(".close-arrow").on("click", function() {
      $("#scoring-data").css("right", "-250px");
      $(".menu-button").css("opacity", "1");
    });

});
