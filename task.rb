require_relative './connect.rb'
require_relative './tweet.rb'

# 監視対象をチェックし、ツイートとslackで報告を行う
# @version 1.0
# @author kyohei ito
class Task
	# 環境変数を読み込む
	def initialize
		@addr = ENV['CHECK_ADDRESS']
		@flag = ENV['CHECK_PROTOCOL']
		@@success = ENV['TWEET_SUCCESS']
		@@fail = ENV['TWEET_FAIL']
	end

  # タスクの実行(監視対象をチェックし、ツイートとslackで報告を行う)
	def exec
		check(@addr)
		alert(@tweet, @notify)
	end

	public

	# 監視対象をチェックする
	def check(addr)
		case @flag
		when "ICMP"
			if ping(addr)
				@tweet  = @@success
				@notify = "#{@addr}, OK"
			else
				@tweet  = @@fail
				@notify = "#{@addr}, NG"
			end
		else
			if get_status_code(addr) == "200"
				@tweet  = @@success
				@notify = "#{@addr}, OK"
			else 
				@tweet  = @@fail
				@notify = "#{@addr}, NG"
			end
		end

		# ツイートとslackで報告を行う
		# @param [String] tweet ツイートしたい文章
		# @param [String] notify slackへ投稿したい文章
		# @return [Integer] slack への投稿が成功した場合は 0、失敗は 1
		def alert(tweet, notify)
			Tweet.new.tweet(tweet)
			notify( notify )
		end
	end
end
