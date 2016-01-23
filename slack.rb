require "slack-notifier"

# slack, Incoming WebHooks
# @see https://api.slack.com/incoming-webhooks
# @param [String] text 通知したい内容
# @return [Integer] 成功した場合は 0、失敗は 1
def notify(text)
	url = ENV['WEBHOOK_URL']
	if url
		Slack::Notifier.new(url).ping(text)
	else
		STDERR.print("'WEBHOOK_URL' is undefined.")
		return 1
	end

end
