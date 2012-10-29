module UsersHelper
  
  def avatar_for(user, size = 48)
    default_url = "/assets/avatar.png"
    gravatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5::hexdigest(user.email.downcase)}?s=#{size}&d=mm"
    image_tag(gravatar_url, alt: user.username, class: 'gravatar')
  end
end
