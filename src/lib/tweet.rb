require 'twitter'

# Twitter API を使用するクラス
# @version 1.1
# @author kyohei ito
# @see https://apps.twitter.com/
# @see http://www.rubydoc.info/gems/twitter
class Tweet
	def initialize
		@flag = true
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV['YOUR_CONSUMER_KEY']
			config.consumer_secret     = ENV['YOUR_CONSUMER_SECRET']
			config.access_token        = ENV['YOUR_ACCESS_TOKEN']
			config.access_token_secret = ENV['YOUR_ACCESS_SECRET']
		end
	end

	# ツイートの実行
	# @param [String] text ツイートしたい文章
	# @return [Twitter::Tweet] The created Tweet. When the tweet is deemed a duplicate by Twitter, returns the last Tweet from the user's timeline.
	def tweet(text)
		return STDERR.print("No Tweet text") unless text

		unless set_twitter_api_key?
			STDERR.print("Some Twitter API key are NOT exported.")
		else 
			begin
				@client.update(text.chomp)
			rescue => ex
				STDERR.print("Error occurred : #{ex}")
			end
		end
	end

	private

	# 必要なAPIキーが設定されているか確認する
	# @return [Boolean] TwitterのAPIキーが全て設定されている場合は true を返す
	def set_twitter_api_key?
		@flag = false unless @client::consumer_key
		@flag = false unless @client::consumer_secret
		@flag = false unless @client::access_token
		@flag = false unless @client::access_token_secret
		@flag
	end
end
