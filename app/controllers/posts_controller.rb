# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :require_logged_user

  def show
    @post = current_user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    CreatePost.call(current_user, create_post_params) do |action|
      action.on(:success) do |post|
        redirect_to edit_post_path(post)
      end

      action.on(:error) do |post|
        @post = post
        render :new
      end
    end
  end

  def edit
    attrs = current_user
            .posts
            .find(params[:id])
            .attributes
            .symbolize_keys
            .slice(:id, :description, :keywords, :show_location, :visibility)

    @post_form = PostForm.new(attrs)
  end

  def update
    post = current_user
           .posts
           .find(params[:id])

    @post_form = PostForm.new({id: post.id}.merge(update_post_params))

    UpdatePost.call(post, @post_form) do |action|
      action.on(:success) do
        redirect_to post_path(post)
      end

      action.on(:error) do
        render :edit
      end
    end
  end

  private def create_post_params
    params.require(:post).permit(:raw_photo, :description)
  end

  private def update_post_params
    params
      .require(:post)
      .permit(
        :description,
        :show_location,
        :visibility,
        :keywords
      )
  end
end
