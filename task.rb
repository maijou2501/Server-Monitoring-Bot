require_relative './check.rb'
require_relative './slack.rb'
require_relative './tweet.rb'

HTTP_OK="200"

# 監視対象をチェックし、ツイートとslackで報告を行う
# @version 1.0
# @author kyohei ito
# @note 環境変数'CHECK_ADDRESS'は必須設定項目
class Task
	# 環境変数を読み込む
	def initialize
		@addr = ENV['CHECK_ADDRESS']
		@flag = ENV['CHECK_PROTOCOL']    || "HTTP"
		@twitter_success = ENV['TWEET_SUCCESS'] || "稼働中"
		@twitter_fail    = ENV['TWEET_FAIL']    || "停止中"
		@slack_success   = ENV['SLACK_SUCCESS'] || "稼働中"
		@slack_fail      = ENV['SLACK_FAIL']    || "停止中"
	end

	# タスクの実行(監視対象をチェックし、ツイートとslackで報告を行う)
	def exec
		check(@addr)
		alert(@tweet, @notify)
	end

	public

	# 監視対象をチェックする
	def check(addr)

		# 引数評価結果が nil, FALSE 以外の場合、返り値 1 を返す
		unless @addr
			STDERR.print("'CHECK_ADDRESS' is undifined.")
			return 1
		end

		# flag 記載のプロトコルで死活監視
		case @flag
		when "ICMP"
			if ping(addr)
				@check = TRUE
			else
				@check = FALSE
			end
		when "HTTP"
			if get_status_code(addr) == HTTP_OK
				@check = TRUE
			else 
				@check = FALSE
			end
		else # ICMP, HTTP 以外が設定されたら、返り値 1 を返す
			STDERR.print("'CHECK_PROTOCOL' is invalid setting.")
			return 1
		end

		if @check then
			@tweet  = @twitter_success
			@notify = @slack_success
		else 
			@tweet  = @twitter_fail
			@notify = @slack_fail
		end

		# ツイートとslackで報告を行う
		# @param [String] tweet ツイートしたい文章
		# @param [String] notify slackへ投稿したい文章
		# @return [Integer] slack への投稿が成功した場合は 0、失敗は 1
		def alert(tweet, notify)
			Tweet.new.tweet(@tweet)
			notify(@notify)
		end
	end
end
