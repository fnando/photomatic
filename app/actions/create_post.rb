# frozen_string_literal: true

class CreatePost
  include Voltage.call

  attr_reader :params, :user

  def initialize(user, params)
    @user = user
    @params = params
  end

  def form
    @form ||= CreatePostForm.new(params)
  end

  def post
    @post ||= user.posts.new(params)
  end

  def call
    post.raw_photo.attach(params[:raw_photo])

    return emit(:error, post) unless post.valid?

    post.save!

    ProcessImageWorker.perform_async(post.id)

    emit :success, post
  end
end
