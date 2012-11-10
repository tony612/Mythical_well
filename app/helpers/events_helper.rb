# encoding: utf-8
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

  def time_select
    options_for_select((('8'..'23').to_a+('0'..'7').to_a).map{|t| [t+':00', t+':30']}.flatten)
  end

  def date_brief desc
    arr = desc.split(';')
    if arr.length == 1
      arr[0]
    else
      arr[0] + '等'
    end
  end
end
