$(document).ready(function(){
  $("#input-1").rating();
  $('#input-1').on('rating.change', function(event, value, caption) {
      console.log(value);
      console.log($(this).attr("data-meal-id"));
  });
})
