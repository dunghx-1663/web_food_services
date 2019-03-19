 $(document).on('turbolinks:load', function(){ 
    $('body').on('click', '#add_food_to_cart', function(){
      var food_id = $(this).data('food-id');   
      var quantity = $('.quantity input[name="quantity"]').val();
      $.ajax({
        url: '/carts',
        type: 'POST',
        data: {'food_id': food_id, 'quantity': quantity},
        dataType: 'script',
        success: function(){
          alert('Đặt hàng thành công');
        },
        error: function(argument) {
          alert('Đặt hàng thất bại');
        }
      });
    });
  });