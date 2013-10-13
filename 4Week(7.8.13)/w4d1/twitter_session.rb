require 'oauth'
require 'launchy'
require 'yaml'
require 'json'

class TwitterSession

  CONSUMER_KEY = "5Tbl9bO92GS3Zai9yqLMUw"
  CONSUMER_SECRET = "WbFIeU6zHhvw6JqI0USfaAFQQ9R0M0ndZkcKaR3FY"
  CONSUMER = OAuth::Consumer.new(
    CONSUMER_KEY, CONSUMER_SECRET, :site => "https://twitter.com")

  def self.get_token(token_file = 'secrets.rb')

    if File.exist?(token_file)
      File.open(token_file) { |f| YAML.load(f) }
    else
      access_token = self.request_access_token
      File.open(token_file, "w") { |f| YAML.dump(access_token, f) }

      access_token
    end
  end

  def self.access_token
    @@access_token ||= TwitterSession::get_token
  end

  def self.get(uri)
    self.access_token.get(uri).body
  end

  private

  def self.request_access_token

    request_token = CONSUMER.get_request_token
    authorize_url = request_token.authorize_url
    puts "Go to this URL: #{authorize_url}"
    Launchy.open(authorize_url)

    puts "Login, and type your verification code in"
    oauth_verifier = gets.chomp

    access_token = request_token.get_access_token(
      :oauth_verifier => oauth_verifier)

  end

end