$(document).ready(function() {
  $(document).on('click', 'a.jquery-logout', function(event) {
    event.preventDefault();
    var $this = $(this);
    $.ajax({
      method: "delete",
      url: $this.attr('href')
    }).done(function (response) {
      alert('Goodbye');
      window.location.href = "/balls";
    });
  });

  // AJAX-ify Answers

  $(".ball").on("click", function (event) {
    event.preventDefault();
    console.log("Hello from the click answer event")
    var target = $(this).children().attr("href");
    console.log(target);
    var request = $.ajax({
      method: "get",
      url: target
    });
    request.done(function (resultInfo) {
      console.log(resultInfo);
      $(".result").html(resultInfo);
    });
  });



});
