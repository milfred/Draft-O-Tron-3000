$(function() {

  $(".update-pt-values").on("submit", function(event) {
    event.preventDefault();

    var $form = $(this);
    var data = $form.serialize();
    var method = $form.attr("method");
    var url = $form.attr("action");

      var request = $.ajax({
        url: url,
        method: method,
        data: data
      });
      $("#scoring-data").css("right", "-400px");
      $(".menu-button").css("opacity", "1");
      location.reload(true);
  });

});
