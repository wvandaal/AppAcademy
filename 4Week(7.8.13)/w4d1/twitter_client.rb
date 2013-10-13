require 'addressable/uri'
require_relative 'twitter_session'

class Status

  def initialize(author, message)
    @author = author
    @message = message
  end

  def self.get_by_id(id)
    uri = Addressable::URI.new(
    scheme: "https",
    host: "api.twitter.com",
    path: "1.1/statuses/show/#{id}.json"
    ).to_s
    self.parse(TwitterSession.access_token.get(uri).body)
  end

  def self.parse(json)
    tweet = JSON.parse(json)
    Status.new(tweet["user"]["screen_name"],tweet["text"])
  end

  def text
    @message
  end

  def user
    User.get_by_screenname(@author)
  end

end


