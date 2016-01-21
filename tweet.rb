require 'rubygems'
require 'twitter'
require_relative './alert.rb'

class Tweet
	def initialize
		@text = <<-EOF.split("\n")
# ここに31行分のテキストを入れる
		EOF

		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV['YOUR_CONSUMER_KEY']
			config.consumer_secret     = ENV['YOUR_CONSUMER_SECRET']
			config.access_token        = ENV['YOUR_ACCESS_TOKEN']
			config.access_token_secret = ENV['YOUR_ACCESS_SECRET']
		end

	end
	def random_tweet
		tweet = @text[rand(@text.length)]
		update(tweet)
	end
	def daily_tweet
		#tweet = @text[Time.now.day - 1]

		addr = ENV['CHECK_HOST']

		if ping(addr)
			tweet = "#{addr}, OK"
			notify("#{addr}, OK")

		else
			tweet = "#{addr}, NG"
			notify("#{addr}, NG")
		end

		update(tweet)
	end
	private
	def update(tweet)
		return nil unless tweet
		begin
			@client.update(tweet.chomp)
		rescue => ex
			nil # todo
		end
	end
end
