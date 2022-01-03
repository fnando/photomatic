# frozen_string_literal: true

ActionView::Base.field_error_proc = lambda do |html_tag, _instance|
  html_tag.to_s
end

module FormBuilderExtensions
  def infer_type(attribute)
    case attribute.to_s
    when /boolean/
      :boolean
    when /email/
      :email
    when /description/
      :text
    else
      :string
    end
  end

  def infer_helper_name(type)
    case type
    when :boolean
      :check_box
    when :text
      :text_area
    when :email
      :email_field
    when :url
      :url_field
    else
      :text_field
    end
  end

  def submit(**options)
    super(**options, class: "btn-primary")
  end

  def field(attribute, type = nil)
    error_class = "with-errors" if object.errors[attribute].any?
    type ||= infer_type(attribute)
    wrapper_css_names = ["field", type, error_class].compact.join(" ")

    label_tag = label(attribute)
    field_tag = public_send(infer_helper_name(type), attribute)
    error_tag = error_for(attribute)

    @template.content_tag :p, class: wrapper_css_names do
      if type == :boolean
        field_tag + label_tag + error_tag
      else
        label_tag + field_tag + error_tag
      end
    end
  end

  def error_for(attribute)
    return unless object.errors[attribute].any?

    @template.content_tag :span,
                          object.errors[attribute].first,
                          class: "field-error"
  end

  def placeholder(attribute)
    @template.t(
      attribute,
      scope: [:form, :placeholders, object_name],
      default: ""
    )
  end

  def text_field(attribute, **options)
    options[:placeholder] ||= placeholder(attribute)
    super(attribute, **options)
  end

  def email_field(attribute, **options)
    text_field(attribute, **options, type: "email")
  end

  def text_area(attribute, **options)
    options[:placeholder] ||= placeholder(attribute)
    super(attribute, **options)
  end

  def label(attribute, label = nil, **options)
    label ||= @template.t(
      attribute,
      scope: [:form, :labels, object_name],
      default: attribute.to_s.humanize
    )

    @template.content_tag :label, for: [object_name, attribute].join("_"),
                                  **options do
      @template.content_tag(:span, label) + hint(attribute)
    end
  end

  def hint(attribute)
    hint = @template.t(
      attribute,
      scope: [:form, :hints, object_name],
      default: ""
    )

    return if hint.blank?

    @template.content_tag :span, hint, class: "field-hint"
  end
end

module ActionView
  module Helpers
    class FormBuilder
      prepend FormBuilderExtensions
    end
  end
end
