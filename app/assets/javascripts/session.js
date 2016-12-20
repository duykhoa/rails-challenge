$(document).ready(function(){
  user_id_hash = {
    "kevin": 1,
    "ernest": 2,
    "admin": 3
  }

  $("#login-form").on("submit", function(e) {
    e.preventDefault();
    user_name = $("#user_name").val();
    user_id = user_id_hash[user_name];

    if (user_id !== null) {
      Cookies.set("user_id", user_id, { expires: 1 });
    }
  })
})
