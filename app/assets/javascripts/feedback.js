$(document).ready(function(){
  $("#input-1").rating();
  $('#input-1').on('rating.change', function(event, value, caption) {
    $.ajax({
      url: "/api/v1/rates",
      method: "post",
      data: { user_id: 1, ratable_id: 1, ratable_type: "meal", point: value }
    })
  });
})
