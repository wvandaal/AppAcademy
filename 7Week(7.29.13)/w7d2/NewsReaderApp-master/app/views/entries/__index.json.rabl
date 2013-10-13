object @feed
attributes(:id, :title, :url)
child(:entries){
  attributes(:id, :guid, :link, :published_at, :title, :json, :feed_id)
}