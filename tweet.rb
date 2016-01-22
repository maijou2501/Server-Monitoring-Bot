require 'rubygems'
require 'twitter'
require_relative './connect.rb'

# Twitter API を使用するクラス
# @version 1.0
# @author kyohei ito
# @see https://apps.twitter.com/
class Tweet

	# init
	def initialize
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV['YOUR_CONSUMER_KEY']
			config.consumer_secret     = ENV['YOUR_CONSUMER_SECRET']
			config.access_token        = ENV['YOUR_ACCESS_TOKEN']
			config.access_token_secret = ENV['YOUR_ACCESS_SECRET']
		end
	end

	# tweet execute
	def tweet(text)
		return nil unless text
		begin
			@client.update(text.chomp)
		rescue => ex
			nil # todo
		end
	end
end
