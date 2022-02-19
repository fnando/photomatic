# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :require_logged_user

  def create
    LikePost.call(current_user, params[:post_id]) do |action|
      action.on(:success) do
        render json: {success: true}
      end

      action.on(:unauthorized) do
        render json: {success: false}, status: :not_found
      end
    end
  end

  def delete
    UnlikePost.call(current_user, params[:post_id]) do |action|
      action.on(:success) do
        render json: {success: true}
      end

      action.on(:unauthorized) do
        render json: {success: false}, status: :not_found
      end
    end
  end
end
