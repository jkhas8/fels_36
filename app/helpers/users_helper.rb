module UsersHelper
  def gravatar_for(user, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = options[:size]
    name = options[:name]
    name ||= user.name
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: name, title: name, size: "#{size}x#{size}",
                            class: "gravatar")
  end
end
