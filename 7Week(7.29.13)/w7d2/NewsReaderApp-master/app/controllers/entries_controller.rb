class EntriesController < ApplicationController
  respond_to :json

  def index
    feed = Feed.find(params[:feed_id])

    last = feed.entries.last

    if last && last.updated_at < Time.now - 2.minutes
      feed = feed.reload
    end

    @entries = feed.entries.order("published_at DESC")

    respond_with @entries
  end
end
