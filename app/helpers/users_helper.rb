module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "img-circle")
  end

  def avatar_for(user)
    image_tag(user.avatar_url, alt: user.name, class: "img-circle")
  end
end
