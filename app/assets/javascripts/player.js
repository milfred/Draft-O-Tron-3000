$(function() {

  $("#search").hide();

  $(".tab").on("click", function(event) {
    var $selectedTab = $(this);
    var tabId = "#" + $selectedTab.attr("id");
    var contentId = tabId.substring(0, tabId.length - 4);

    console.log(contentId);

    $(".tab-content").hide();
    $(".tab").removeClass("selected");
    $(contentId).fadeIn(600);
    $selectedTab.addClass("selected");


  });

});
