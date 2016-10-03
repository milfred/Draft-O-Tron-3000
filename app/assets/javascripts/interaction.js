$(function() {
  $(".scroll-to-top").hide();
  setDrafted();

  // Float table header
  var $table = $('table.players');
  $table.floatThead({top: 54});


  // Display scroll to top button
	$(window).scroll(function(){

		if ($(this).scrollTop() > 500) {
			$('.scroll-to-top').fadeIn();
		} else {
			$('.scroll-to-top').fadeOut();
		}
	});


	// Click event to scroll to top
	$(".scroll-to-top").click(function(){
		$("html, body").animate({scrollTop : 0},300);
		return false;
	});


  // Implement jquery ui drag sortable function to
  // drag and drop player rows
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


  // Update player rank after drag and drop
  function updateRank() {
    $(".rank").each(function(index) {
      $(this).html(index + 1);
      var data = "player_rank=" + $(this).html();
      var rankingId = $(this).attr("id").substring(5, $(this).attr("id").length);

      var request = $.ajax({
        url: "/rankings/" + rankingId,
        method: "PATCH",
        data: data
      });
    });
  }

  // Close/open settings panel
  $(".menu-button").on("click", function() {
    $("#settings").css("right", "0");
    $(".menu-button").css("opacity", "0");
  });
  $(".close-arrow").on("click", function() {
    $("#settings").css("right", "-400px");
    $(".menu-button").css("opacity", "1");
  });


  // Smooth scroll
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
