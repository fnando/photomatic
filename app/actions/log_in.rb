# frozen_string_literal: true

class LogIn
  include Signal.call

  attr_reader :form

  def initialize(form)
    @form = form
  end

  def call
    return emit(:error) unless form.valid?

    # 1. generate login link
    # 2. send email
    # 3. emit :success signal
  end
end
