$(document).ready(function(){
   $(function () {
      $('.navbar-toggle-sidebar').click(function () {
  		$('.navbar-nav').toggleClass('slide-in');
  		$('.side-body').toggleClass('body-slide-in');
  		$('#search').removeClass('in').addClass('collapse').slideUp(200);
  	});

  	$('#search-trigger').click(function () {
  		$('.navbar-nav').removeClass('slide-in');
  		$('.side-body').removeClass('body-slide-in');
  		$('.search-input').focus();
  	});
  });


  $(function(){
    $("#show-limit").on("change", function(){
      $(this).closest("form").trigger("submit");
    });
  })
});
