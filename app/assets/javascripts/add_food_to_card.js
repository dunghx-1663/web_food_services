// function bindModal() {
//   $('#addFood').on('show.bs.modal', function(e) {
//     var food_id = $(e.relatedTarget).val();
//     $(e.currentTarget).find('input[name="food_id"]').val(food_id);
//   });
// }

$('body').on('click', function(){
  $('#addFood').on('show.bs.modal', function(e) {
    var food_id = $(e.relatedTarget).val();
    $(e.currentTarget).find('input[name="food_id"]').val(food_id);
  });
});
$(document).on('turbolinks:load', function(){ 
  $('body').on('click', '#add_food', function(){
    var food_id = $(this).data('food-id');   
    var quantity = $('.modal-body input[name="amount"]').val();
    $.ajax({
      url: '/carts',
      type: 'POST',
      data: {'food_id': food_id, 'quantity': quantity},
      dataType: 'script',
      success: function(){
        alert('<%= I18n.t "cart.success" %>');
      },
      error: function(argument) {
        alert('<%= I18n.t "cart.error" %>');
      }
    });
  });

});