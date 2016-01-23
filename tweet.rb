require 'twitter'

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
	# @return [nil] 引数評価結果が nil, FALSE 以外の場合。Twitter API key がセットされていない場合
	# @return [Twitter::Tweet] The created Tweet. When the tweet is deemed a duplicate by Twitter, returns the last Tweet from the user's timeline.
	def tweet(text)
		return nil unless text

		# 必要なAPIキーが設定されているか確認する
		flag = TRUE
		flag = FALSE unless @client::consumer_key
		flag = FALSE unless @client::consumer_secret
		flag = FALSE unless @client::access_token
		flag = FALSE unless @client::access_token_secret

		# 必要なAPIキーが設定されているか確認する
		if flag then
			begin
				@client.update(text.chomp)
			rescue => ex
				nil # todo
			end
		else
			STDERR.print("Some Twitter API key are NOT exported.")
			nil
		end
	end
end
