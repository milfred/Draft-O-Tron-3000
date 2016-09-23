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

<<<<<<< HEAD
      $("#scoring-data").css("right", "-250px");
=======
      $("#scoring-data").css("right", "-400px");
>>>>>>> 1fb2238ea81024b1075bcd78ea8362006d40a6f1
      $(".menu-button").css("opacity", "1");
      location.reload(true);
  });

});
