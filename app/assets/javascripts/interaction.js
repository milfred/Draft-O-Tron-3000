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

  $table.floatThead({top: 54});

  // Check to see if the window is top if not then display button
	$(window).scroll(function(){

		if ($(this).scrollTop() > 500) {
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

  $("#search-results").on("click", "a", function() {
    var playerLink = $(this);
    var playerId = $(playerLink.attr('href')).selector;
    var rankingId = $(playerId).find(".rank").attr("id");
    var playerStatus = $(playerId).find(".player-status");
    var searchSetting = $(".search-setting").val();
    var statusLookup = {
      available: 0,
      targeted: 1,
      drafted: 2,
      unavailable: 3
    };
    var data = "status=" + statusLookup[searchSetting];

    $("body", "html").animate({
      scrollTop : $(playerLink.attr('href')).offset().top - 85
    }, 300);
    if (searchSetting == "available") {
      playerStatus.val("available");
      playerStatus.closest("tr").removeClass("targeted-player drafted-player unavailable-player");
    } else if (searchSetting == "drafted") {
      playerStatus.val("drafted");
      playerStatus.closest("tr").addClass("drafted-player");
    } else if (searchSetting == "targeted") {
      playerStatus.val("targeted");
      playerStatus.closest("tr").addClass("targeted-player");
    } else if (searchSetting == "unavailable") {
      playerStatus.val("unavailable");
      playerStatus.closest("tr").addClass("unavailable-player");
    }

    var request = $.ajax({
      url: "/rankings/" + rankingId,
      method: "PATCH",
      data: data
    });
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
      $("#settings").css("right", "0");
      $(".menu-button").css("opacity", "0");
    });
    $(".close-arrow").on("click", function() {
      $("#settings").css("right", "-400px");
      $(".menu-button").css("opacity", "1");
    });

    $('a[href*="#"]:not([href="#"])').click(function() {
      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
        if (target.length) {
          $('html, body').animate({
            scrollTop: target.offset().top
          }, 500);
          return false;
        }
      }
    });

});
