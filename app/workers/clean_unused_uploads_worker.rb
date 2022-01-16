# frozen_string_literal: true

class CleanUnusedUploadsWorker
  include Sidekiq::Worker

  def perform
    ActiveStorage::Blob
      .unattached
      .where("active_storage_blobs.created_at <= ?", 1.day.ago)
      .find_each(&:purge_later)
  end
end
