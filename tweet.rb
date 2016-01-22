require 'rubygems'
require 'twitter'
require_relative './connect.rb'

# Twitter API を使用するクラス
# @version 1.0
# @author kyohei ito
# @see https://apps.twitter.com/
# @see http://www.rubydoc.info/gems/twitter
class Tweet

	# APIキーを設定する
	def initialize
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV['YOUR_CONSUMER_KEY']
			config.consumer_secret     = ENV['YOUR_CONSUMER_SECRET']
			config.access_token        = ENV['YOUR_ACCESS_TOKEN']
			config.access_token_secret = ENV['YOUR_ACCESS_SECRET']
		end
	end

	# ツイートの実行
	# @param [String] text ツイートしたい文章
	# @return [nil] 引数が String 型以外の場合は nil
	# @return [Twitter::Tweet] The created Tweet. When the tweet is deemed a duplicate by Twitter, returns the last Tweet from the user's timeline.
	def tweet(text)
		return nil unless text
		begin
			@client.update(text.chomp)
		rescue => ex
			nil # todo
		end
	end
end
