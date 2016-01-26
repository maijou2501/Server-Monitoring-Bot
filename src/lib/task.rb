require_relative './check.rb'
require_relative './slack.rb'
require_relative './tweet.rb'

# 環境変数を読み込んで監視・報告タスクを行う
# @version 1.1
# @author kyohei ito
# @note 環境変数'CHECK_ADDRESS'は必須設定項目
class Task
	def initialize
		@addr            = ENV['CHECK_ADDRESS']
		@proto           = ENV['CHECK_PROTOCOL']
		@time_out        = ENV['CHECK_TIMEOUT']
		@twitter_success = ENV['TWEET_SUCCESS'] || "稼働中"
		@twitter_fail    = ENV['TWEET_FAIL']    || "停止中"
		@slack_success   = ENV['SLACK_SUCCESS'] || "稼働中"
		@slack_fail      = ENV['SLACK_FAIL']    || "停止中"
	end

	# タスクの実行(監視対象をチェックし報告を行う)
	# @return [Integer] タスクが終了した場合は 0, その他は nil
	def exec
		unless @addr
			STDERR.print("Check Address is undifined.")
		else
			check = Check.new
			check.addr     = @addr
			check.proto    = @proto    if @proto
			check.time_out = @time_out if @time_out
			if check.exec
				@tweet  = @twitter_success
				@notify = @slack_success
			else 
				@tweet  = @twitter_fail
				@notify = @slack_fail
			end
			Tweet.new.tweet(@tweet)
			slack(@notify)
		end
	end
end
