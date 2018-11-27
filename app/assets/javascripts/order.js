$(document).ready(function () {
    $('#update-order button').click(function () {
      if (confirm('<%= I18n.t "views.orders.checked.confirm" %>')) {
        $.ajax({
          url: '/orders/' + $(this).attr("data-id"),
          type: 'PATCH',
          data: {'order_id': $(this).attr("data-id")},
          datatype: 'script'
        });
      }
    });
  });