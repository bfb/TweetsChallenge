require 'rubygems'
require 'tweetstream'
require 'json'
require 'mongo'

# Initializing the mongo connection
connection = Mongo::Connection.new
database = connection.db("tweets_challenge")
collection_tweets = database.collection("tweets")

# Configuring the streaming api auth
TweetStream.configure do |config|
  config.consumer_key = 'wW5YIadiCewfC9Bz4cbRYA'
  config.consumer_secret = 'K9Xe5FGsAX8JPdplQu8b7KYYpJRB44bQf6dltrjf68'
  config.oauth_token = '66568070-TeoMyDPOhUkm0rsJDizT54n3nnKZrNrczlFcznOac'
  config.oauth_token_secret = '3r8jH4pv8W5xquLfEVjshVPTCc6x8EbsnWv7FRp2JY'
  config.auth_method = :oauth
  config.parser   = :json_gem
end

# Verifying the limit parameter
parameter = ARGV[0].to_i
parameter != 0 ? limit = parameter : limit = 20

counter = 0
# Initializing the tweets capture
TweetStream::Client.new.sample do |status, client|
  collection_tweets.insert({:tweet => "#{status.text}"})
  counter += 1
  client.stop if counter >= limit
end