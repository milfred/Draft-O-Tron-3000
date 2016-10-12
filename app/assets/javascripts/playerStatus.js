$(function() {

  // Update player status via select field
  $(".player-status").change(function() {
    var $playerStatus = $(this);
    var rankId = $playerStatus.closest("tr").find(".rank").attr("id");
    var rankingId = rankId.substring(5, rankId.length);
    var statusLookup = {
      available: 0,
      targeted: 1,
      drafted: 2,
      unavailable: 3
    };
    var data = "status=" + statusLookup[$playerStatus.val()];

    updateStatusStyes($playerStatus, $playerStatus.val());
    updateStatus(rankingId, data);
    setDrafted();
  });


  // Update player status via search form
  $("#search-results").on("click", "a", function() {
    var playerLink = $(this);
    var playerId = $(playerLink.attr('href')).selector;
    var rankId = $(playerId).find(".rank").attr("id");
    var rankingId = rankId.substring(5, rankId.length);
    var $playerStatus = $(playerId).find(".player-status");
    var statusSetting = $("#status-setting").val();
    var statusLookup = {
      available: 0,
      targeted: 1,
      drafted: 2,
      unavailable: 3
    };
    var data = "status=" + statusLookup[statusSetting];

    $("body", "html").animate({
      scrollTop : $(playerLink.attr('href')).offset().top - 85
    }, 300);
    if ($(".search-setting").val() === "update") {
      console.log($(".search-setting").val());
      updateStatusStyes($playerStatus, statusSetting);
      updateStatus(rankingId, data);
      if (statusSetting === "drafted") {
        setDrafted();
      }
    }
  });
});


function setDrafted() {
  $("#team").find("tbody").html("");
  $(".player-status").each(function(index, value) {
    var status = $(this);
    var playerName = status.closest("tr").find(".player-name").text();
    var playerPosition = status.closest("tr").find(".player-position").text().substring(0, 2);
    var playerTeam = status.closest("tr").find(".player-team").text();
    var playerBye = status.closest("tr").find(".player-bye").text();

    if (status.val() === "drafted") {
      $("#team").find("tbody").append("<tr><td>" + playerName + "</td><td>" + playerPosition + "</td><td>" + playerTeam + "</td><td>" + playerBye + "</td></tr>");
    }
  });
}

function updateStatus(rankingId, data) {
  var request = $.ajax({
    url: "/rankings/" + rankingId,
    method: "PATCH",
    data: data
  });
}

function clearStatusStyles(selectedElement) {
  selectedElement.closest("tr").removeClass("targeted-player drafted-player unavailable-player");
}

function updateStatusStyes(statusElement, newStatus) {
  clearStatusStyles(statusElement);
  if (newStatus !== "available") {
    statusElement.closest("tr").addClass(newStatus + "-player");
    statusElement.closest("tr").removeClass("white");
  }
  if (statusElement.val() !== newStatus) {
    statusElement.val(newStatus);
  }
}
