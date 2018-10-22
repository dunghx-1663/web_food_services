$(function() {
    $("#submit-search").on("click", function(){
      if($("#search_text").val() !== "")
      $.ajax({
        url: "/",
        method: "get",
        data: {search_text: $("#search_text").val()}
      })
    })
});