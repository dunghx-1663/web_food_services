charged()
getPrice = /\d+(.|,)\d/
$("li input").on("change",function () {
    charged()
})
function charged(){
    totalPrice = 0
    price = $(".price");
    quantity = $(".quantity");
    for (var i = 0; i < price.length; i++){
        totalPrice += parseFloat(getPrice.exec(price[i].textContent)[0]) * parseFloat(quantity[i].value)
    }
    $("#total").html(totalPrice + " $")
}
function update_cart(){
    id = $(".col-sm-6 ul li");
    price = $(".price");
    quantity = $(".quantity");
    array = []
    for(var i =0; i < id.length;i++){
        object = {id: id[i].id, quantity: quantity[i].value}
        array.push(object)
    }
    return array

}
$("#update-cart").on("click",function () {
    var items = update_cart();
    $.ajax({
        url: "/carts",
        type: "patch",
        dataType: "script",
        data: {cart:{items: items}}
    })
})