# encoding: utf-8
module EventsHelper
  def comment_raw(text)
    return "" if text.blank?
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
    return "暂无描述" if desc.blank?
    arr = desc.split(';')
    if arr.length == 1
      arr[0]
    else
      arr[0] + '等'
    end
  end

  def origin_desc event
    return "暂无描述" if event.date_desc.blank?
    event.date_desc.gsub(';', ';   ')
  end

  def events_follow_tag(event)
    return "" unless user_signed_in?
    return "" if event.blank?
    return "" if own? event
    class_name = event.followers.include?(current_user) ? "followed" : "follow"
    icon = content_tag("i", "", class: "icon-eye-open icon-large #{class_name}")
    link_to raw(icon), "#", :onclick => "return Events.follow(this);",
            'data-id' => event.id,
            'data-followed' => (class_name == "followed")
  end

  def my_image_tag url
    if FileTest.exist?(url)
      image_tag url
    else
      p Rails.root.join('public' 'noimage.png')
      image_tag 'http://farm9.staticflickr.com/8202/8219119189_cc8c04f101.jpg'
    end
  end
end
