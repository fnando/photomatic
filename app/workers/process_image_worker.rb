# frozen_string_literal: true

class ProcessImageWorker
  include Sidekiq::Worker

  def perform(post_id)
    ProcessImage.call(post_id)
  end
end
