# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :require_logged_user

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.photo.attach(post_params[:photo])
    @post.save!
    redirect_to new_post_path(success: true)
  end

  private def post_params
    params.require(:post).permit(:photo)
  end
end
