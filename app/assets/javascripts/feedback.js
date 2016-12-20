$(document).ready(function(){
  $(".rating").rating();
  $('.rating').on('rating.change', function(event, value, caption) {
    ratable_id = $(this).data('ratable_id')
    ratable_type = $(this).data('ratable_type')

    $.ajax({
      url: "/api/v1/rates",
      method: "post",
      data: { user_id: 1, ratable_id: ratable_id, ratable_type: ratable_type, point: value }
    })
  });
})
