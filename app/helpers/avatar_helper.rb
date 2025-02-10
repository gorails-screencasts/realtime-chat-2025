module AvatarHelper
  def gravatar_url(email, size: 32)
    email_hash = Digest::MD5.hexdigest(email.strip.downcase)
    "https://secure.gravatar.com/avatar/#{email_hash}?s=#{size}&d=mp"
  end

  def user_avatar(user, size: 32)
    image_tag gravatar_url(user.email_address, size: size),
              class: "rounded-full",
              alt: "#{user.name}'s avatar"
  end
end
