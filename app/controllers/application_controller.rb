# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_global_meta_data

  private def set_global_meta_data
    page_meta.tag :user_id, current_user&.id
  end
end
