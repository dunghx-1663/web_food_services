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

  $('.collapse-link').on('click', function () {
    var $BOX_PANEL = $(this).closest('.x-panel'),
      $ICON = $(this).find('i'),
      $BOX_CONTENT = $BOX_PANEL.find('.x-content');

    if ($BOX_PANEL.attr('style')) {
      $BOX_CONTENT.slideToggle(200, function () {
        $BOX_PANEL.removeAttr('style');
      });
    } else {
      $BOX_CONTENT.slideToggle(200);
      $BOX_PANEL.css('height', 'auto');
    }

    $ICON.toggleClass('fa-chevron-up fa-chevron-down');
    return false;
  });

  $('.collapse-link').on('click', function () {
    var $BOX_PANEL = $(this).closest('.legend-panel'),
      $BOX_CONTENT = $BOX_PANEL.find('.x-content');

    if ($BOX_PANEL.attr('style')) {
      $BOX_CONTENT.slideToggle(200, function () {
        $BOX_PANEL.removeAttr('style');
      });
    } else {
      $BOX_CONTENT.slideToggle(200);
      $BOX_PANEL.css('height', 'auto');
    }
    return false;
  });
  
});
