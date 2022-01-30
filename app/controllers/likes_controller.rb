# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :required_logged_user

  def create
    render json: {success: true, create: true}
  end

  def delete
    render json: {success: true, delete: true}
  end
end
