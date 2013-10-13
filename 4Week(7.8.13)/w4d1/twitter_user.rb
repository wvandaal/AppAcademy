require_relative 'twitter_client'
require_relative 'twitter_session'
require 'addressable/uri'

class User

  attr_reader :id, :screenname, :name, :homepage

  def initialize(screenname, id, name, url)
    @id = id
    @screenname = screenname
    @name = name
    @homepage = url
  end

  def self.get_by_screenname(screenname)
    uri = Addressable::URI.new(
      scheme: "https",
      host: "api.twitter.com",
      path: "1.1/users/show.json",
      query_values: {screen_name: "#{screenname}", include_entities: "true"}
    ).to_s
    self.parse(TwitterSession.access_token.get(uri).body)
  end

  def self.parse(json)
    user = JSON.parse(json)
    User.new(user["screen_name"], user["id"], user["name"], user["url"])
  end

  def timeline
    uri = Addressable::URI.new(
      scheme: "https",
      host: "api.twitter.com",
      path: "1.1/statuses/user_timeline.json",
      query_values: {screen_name: "#{@screenname}", count: "5"}
    ).to_s
    JSON.parse(TwitterSession.access_token.get(uri).body).map do |tweet|
      Status.new(tweet["user"]["screen_name"],tweet["text"])
    end
  end

end

class EndUser < User

end