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

  reply: (floor, username) ->
    comment_body = $('#comment_content')
    new_text = "##{floor}楼 @#{username} "
    if comment_body.val().trim().length == 0
      new_text += ''
    else
      new_text = "\n#{new_text}"
    comment_body.focus().val(comment_body.val() + new_text)
    return false


$(document).ready ->
  $("#reply textarea").bind "keydown", "ctrl+return", (el) ->
    if $(el.target).val().trim().length > 0
      $("#reply > form").submit()
    return false

  # Reply by link
  $('.comment_link').live 'click', () ->
    Events.reply($(this).data('floor'), $(this).data('username'))
