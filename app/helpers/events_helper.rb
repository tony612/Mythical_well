module EventsHelper
  def comment_raw(text)
    text.gsub! /\r\n/, "<br>"
    text.gsub! /(@)(\S*\s)/, "<a href=#{root_url}users/\\2>\\1\\2</a>"
    raw text
  end
end
