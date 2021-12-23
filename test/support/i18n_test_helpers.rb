# frozen_string_literal: true

module I18nTestHelpers
  def field(scope)
    I18n.t(scope, scope: "form.labels")
  end

  def button(scope)
    I18n.t(scope, scope: "helpers.submit")
  end
end
