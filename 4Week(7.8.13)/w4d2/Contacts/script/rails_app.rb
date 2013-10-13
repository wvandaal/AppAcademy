require 'addressable/uri'
require 'rest-client'


url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: "/users/4",
  query_values: {token: "adfad;slfja;"}

).to_s



RestClient.delete(url)


