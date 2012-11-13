window.Events =
  follow: (el) ->
    console.log "Test for follow"
    event_id = $(el).data("id")
    followed = $(el).data("followed")
    if followed
      $.ajax
        url: "/events/#{event_id}/unfollow"
        type: "POST"
      $(el).data("followed", false)
      $("i", el).removeClass('followed').addClass("follow")
    else
      $.ajax
        url: "/events/#{event_id}/follow"
        type: "POST"
      $(el).data("followed", true)
      $("i", el).removeClass('follow').addClass('followed')
    false
