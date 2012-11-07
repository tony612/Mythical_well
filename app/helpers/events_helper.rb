module EventsHelper
  def comment_raw(text)
    text.gsub! /\r\n/, "<br>"
    text.gsub! /(@)(\S*\s)/, "<a href=#{root_url}users/\\2>\\1\\2</a>"
    raw text
  end

  def tag_list e
    if e.tags.any?
      raw e.tags.map{|t| link_to t.name, events_path(tag: t.name)} * ', '
    else
      ""
    end
  end
end
