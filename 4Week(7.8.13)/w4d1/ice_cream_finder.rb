require 'rest-client'
require 'json'
require 'addressable/uri'
require 'addressable/template'
require 'nokogiri'
require 'sanitize'

class QueryProcessor
  def self.validate(name, value)
    return !!(value =~ /^[\w ]+$/) if name == "query"
    return true
  end

  def self.transform(name, value)
    return value.gsub(/ /, "+") if name == "query"
    return value
  end
end

def get_key(api_filename)
  File.readlines(api_filename).first.chomp
end

def query_uri(address_str)
  uri = Addressable::Template.new(
 "http://maps.googleapis.com/maps/api/geocode/json?address={query}&sensor=false"
    ).expand(
      {"query" => address_str},
      QueryProcessor
    ).to_str
end

def get_coordinates(address)
  uri = query_uri(address)
  response = JSON.parse(RestClient.get(uri))
  response["results"].first["geometry"]["location"].values
end

def search_nearby(lat, long, types="food", keyword="icecream")
  uri = Addressable::URI.new(
  scheme: "https",
  host: "maps.googleapis.com",
  path: "maps/api/place/nearbysearch/json",
  query_values: {location: "#{lat},#{long}", radius: 500, types: "#{types}", sensor: "false", keyword: "#{keyword}", key: get_key('APIkey.txt')}).display_uri.to_s

  results = JSON.parse(RestClient.get(uri))["results"]
end

def display_location(index, location_hash)
  puts  "[#{index}] #{location_hash['name']}"
  puts  "Rating: #{location_hash['rating']}" unless location_hash['rating'].nil?
  puts  location_hash['vicinity']
  puts  ""
end

def get_directions(origin, dest)
  uri = Addressable::URI.new(
  scheme: "https",
  host: "maps.googleapis.com",
  path: "/maps/api/directions/json",
  query_values: {origin: "#{origin[0]},#{origin[1]}", destination: "#{dest[0]},#{dest[1]}", sensor: "false"}).display_uri.to_s

  legs = JSON.parse(RestClient.get(uri))["routes"].first["legs"]
  puts "DRIVING DIRECTIONS"
  legs.each do |leg|
    leg["steps"].each do |step|
      puts Nokogiri::HTML(step["html_instructions"]).text
    end
  end
end

def main
  print "Enter you address > "
  address = gets.chomp.sub(",", "")
  curr_lat, curr_long = get_coordinates(address)
  search_results = search_nearby(curr_lat, curr_long)
  search_results[0..9].each_with_index do |result, i|
    display_location(i+1, result)
  end
  dest_index = nil
  until (0..9).include?(dest_index)
    print "Enter the number of your destination > "
    dest_index = gets.chomp.to_i - 1
  end
  end_lat, end_long = search_results[dest_index]["geometry"]["location"].values
  get_directions([curr_lat, curr_long], [end_lat, end_long])
end

main


