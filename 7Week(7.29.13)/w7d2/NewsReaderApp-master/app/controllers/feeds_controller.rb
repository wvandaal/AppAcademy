class FeedsController < ApplicationController
  respond_to :html, :only => [:index]
  respond_to :json

  def index
    @feeds = Feed.all
    respond_with @feeds
  end

  def create
    @feed = Feed.find_or_create_by_url(params[:feed][:url])
    if @feed
      respond_with @feed, :location => nil
    else
      respond_with({:errors => ["invalid url"]}, :status => 422, location: nil)
    end
  end

  def destroy
    feed = Feed.find(params[:id])
    feed.destroy
    respond_with feed, :location => nil
  end
end
