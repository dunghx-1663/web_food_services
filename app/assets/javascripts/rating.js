var stars = $(".stars");
var submitStar = function(){
    $.ajax({
        url: '/votes',
        type: "post",
        data: {vote: this.value, food_id: $("#food_id").text()}
    });
}
for(var i = 0; i < stars.length; i++){
    $("#"+stars[i].id).bind('click',submitStar)
}