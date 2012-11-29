window.Events =
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
