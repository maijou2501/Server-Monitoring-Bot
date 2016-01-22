require 'rubygems'
require 'twitter'
require_relative './alert.rb'

class Tweet
	def initialize
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV['YOUR_CONSUMER_KEY']
			config.consumer_secret     = ENV['YOUR_CONSUMER_SECRET']
			config.access_token        = ENV['YOUR_ACCESS_TOKEN']
			config.access_token_secret = ENV['YOUR_ACCESS_SECRET']
		end
		@flag = "http"
	end

	def set(flag)
		@flag = flag
	end

	def daily_tweet
		addr = ENV['CHECK_HOST']

		case @flag
		when "http"
			if get_status_code(addr) == 200
				tweet = ENV['TWEET_SUCCESS']
				notify("#{addr}, OK")
			else 
				tweet = ENV['TWEET_FAIL']
				notify("#{addr}, NG")
			end

		else

			if ping(addr)
				tweet = "#{addr}, OK"
				notify("#{addr}, OK")

			else
				tweet = "#{addr}, NG"
				notify("#{addr}, NG")
			end
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
