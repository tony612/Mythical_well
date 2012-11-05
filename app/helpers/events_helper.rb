module EventsHelper
  def comment_raw(text)
    text.gsub! /\r\n/, "<br>"
    p root_url
    p text
    at = text.match(/(@)(.*\s)/)[1]
    text.gsub! /(@)(.*\s)/, "<a href=#{root_url}\\2>\\1\\2</a>"
    raw text
  end
end
