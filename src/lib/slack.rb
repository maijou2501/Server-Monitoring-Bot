require "slack-notifier"

# slack, Incoming WebHooks
# @see https://api.slack.com/incoming-webhooks
# @param [String] text 通知したい内容
# @return [Integer] 通知が成功した場合は 0, その他は nil
def slack(text)
	return STDERR.print("No notify text") unless text

	url = ENV['WEBHOOK_URL']
	if url
		Slack::Notifier.new(url).ping(text)
	else
		STDERR.print("'WEBHOOK_URL' is undefined.")
	end

end
