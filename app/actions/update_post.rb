# frozen_string_literal: true

class UpdatePost
  include Voltage.call

  attr_reader :user, :form

  def initialize(user, form)
    @user = user
    @form = form
  end

  def call
    return emit(:error) unless form.valid?

    @user.update!(form.attributes)

    emit :success
  end
end
