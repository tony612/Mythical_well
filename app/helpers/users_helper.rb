module UsersHelper

  def avatar_for(user, size = 36)
    default_url = "/assets/avatar.png"
    email = user.blank? ? "test@test.com" : user.email.downcase
    username = user.blank? ? "error" : user.username
    gravatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5::hexdigest(email)}?s=#{size}&d=mm"
    image_tag(gravatar_url, alt: username, class: 'gravatar')
  end
end
