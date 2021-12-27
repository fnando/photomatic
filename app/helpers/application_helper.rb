# frozen_string_literal: true

module ApplicationHelper
  def svg_image_tag(name)
    content_tag :span, class: "svg-#{name}" do
      File.read(
        Rails.root.join("app/assets/images/#{name}.svg")
      ).html_safe # rubocop:disable Rails/OutputSafety
    end
  end
end
