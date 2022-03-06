# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :require_logged_user

  def create
    CommentPost.call(
      user: current_user,
      post_id: params[:post_id],
      text: params[:text]
    ) do |action|
      action.on(:success) do |comment|
        render html: ApplicationController.render(CommentPresenter.new(comment))
      end

      action.on(:unauthorized) do
        render json: {success: false}, status: :not_found
      end
    end
  end
end
