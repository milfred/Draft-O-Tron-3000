$(function() {
  $(".scroll-to-top").hide();
  $(".drafted-players").hide();


  $(".player-status").change(function() {
    var $selectStatus = $(this);
    var $playerName = $selectStatus.closest("tr").find(".player-name");
    $selectStatus.closest("tr").removeClass("targeted-player drafted-player unavailable-player");
    if ($selectStatus.val() === "targeted") {
      $selectStatus.closest("tr").addClass("targeted-player");
      $selectStatus.css("background-image", "url('/assets/down-arrow-gray.png')");
      $playerName.css("background-image", "url('/assets/move-white.png')");
    } else if ($selectStatus.val() === "drafted") {
      $selectStatus.closest("tr").addClass("drafted-player");
      $selectStatus.css("background-image", "url('/assets/down-arrow-white.png')");
      $playerName.css("background-image", "url('/assets/move-white.png')");
      $(".drafted-players #drafted-players-list").append("<li>" + $playerName.find("a").text() + "</li>");
      $(".drafted-players").fadeIn(1000);
      $(".drafted-players").delay(3000).fadeOut(1000);
    } else if ($selectStatus.val() === "unavailable") {
      $selectStatus.closest("tr").addClass("unavailable-player");
      $selectStatus.css("background-image", "url('/assets/down-arrow-gray.png')");
      $playerName.css("background-image", "url('/assets/move-white.png')");
    } else {
      $selectStatus.css("background-image", "url('/assets/down-arrow.png')");
      $playerName.css("background-image", "url('/assets/move-dark.png')");
    }
  });

  var $table = $('table.players');
  $table.floatThead();

  //Check to see if the window is top if not then display button
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
    placeholder: "ui-sortable-placeholder",
    update: function() {
      updateRank();
    },
    axis: "y",
    cursor: "move"
  });

  function updateRank() {
    $(".rank").each(function(index) {
      $(this).html(index + 1);
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
