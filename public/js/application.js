$(document).ready(function() {
  $(document).on('click', 'a.jquery-logout', function(event) {
    event.preventDefault();
    var $this = $(this);
    $.ajax({
      method: "delete",
      url: $this.attr('href')
    }).done(function (response) {
      alert('Goodbye');
      // console.log(response);
      window.location.href = "/balls";
    });
  });
});
