@initial_notify = (type, message) ->
  $.notify { message: message }, type: type
