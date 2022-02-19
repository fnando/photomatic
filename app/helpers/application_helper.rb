# frozen_string_literal: true

module ApplicationHelper
  def svg_image_tag(name)
    content_tag :span, class: "svg-#{name}" do
      File.read(
        Rails.root.join("app/assets/images/#{name}.svg")
      ).html_safe # rubocop:disable Rails/OutputSafety
    end
  end

  def icon(name, **kwargs)
    content_tag :svg, class: "icon icon--#{name}", **kwargs do
      content_tag :use, nil, href: "#icon--#{name}"
    end
  end

  def post_location(post)
    [post.city, post.region, t(post.country, scope: "countries")].join(", ")
  end

  def gravatar(email, size: 50, **kwargs)
    email_digest = Digest::MD5.hexdigest(email.to_s)
    image_tag "https://gravatar.com/avatar/#{email_digest}?s=#{size * 2}",
              **kwargs,
              class: "avatar",
              style: "width: #{size}px; height: #{size}px;"
  end

  def style(**kwargs)
    kwargs
      .map {|key, value| [key.to_s.tr("_", "-"), value].join(": ") }
      .join("; ")
  end

  def page_id
    [controller.controller_name, controller.action_name].join("-")
  end

  def like_button(post)
    data = {
      controller: "like-button",
      action: "click->like-button#handleClick",
      liked: post.liked_by?(current_user),
      post_id: post.id
    }

    content_tag :button, type: "button", data: data do
      icon(:heart_outline) + icon(:heart)
    end
  end
end
