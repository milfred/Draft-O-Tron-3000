$(function() {

  $("#search").hide();
  $("#drafted").hide();

  $(".tab").on("click", function(event) {
    var $selectedTab = $(this);
    var tabId = "#" + $selectedTab.attr("id");
    var contentId = tabId.substring(0, tabId.length - 4);
    var selectedTabId = "#" + $("#settings .selected").attr("id");

    if(tabId != selectedTabId) {
      $(".tab-content").hide();
      $(".tab").removeClass("selected");
      $(contentId).fadeIn(600);
      $selectedTab.addClass("selected");
    }
  });

});
