module UsersHelper
  def load_avatar(user)
  	avatar_id = Digest::MD5::hexdigest(user.email.downcase)
    avatar_url = "https://secure.gravatar.com/avatar/#{avatar_id}"
    image_tag(avatar_url, alt: user.name, class: "avatar")
  end
end
