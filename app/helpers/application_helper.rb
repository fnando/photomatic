# frozen_string_literal: true

module ApplicationHelper
  def svg_image_tag(name)
    content_tag :span, class: "svg-#{name}" do
      File.read(
        Rails.root.join("app/assets/images/#{name}.svg")
      ).html_safe # rubocop:disable Rails/OutputSafety
    end
  end

  def icon(name)
    content_tag :svg, class: "icon icon--#{name}" do
      content_tag :use, nil, href: "#icon--#{name}"
    end
  end

  def with_attribute(*attrs)
    return if attrs.any?(&:blank?)

    concat(yield.html_safe) # rubocop:disable Rails/OutputSafety
  end

  def post_location(post)
    [post.city, post.region, t(post.country, scope: "countries")].join(", ")
  end
end
