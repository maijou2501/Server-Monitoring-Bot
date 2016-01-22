require 'net/http'
require 'net/ping'
require "rubygems"
require "slack-notifier"
require "uri"

# 指定ホストの ping 疎通を確認する
# @param [String] チェックしたいホスト名
# @return [Boolean] 成功した場合は TRUE
def ping(addr)
	pingmon = Net::Ping::External.new(addr)
	if pingmon.ping?
		return TRUE
	else
		return FALSE
	end
end

# slack, Incoming WebHooks
# @see https://api.slack.com/incoming-webhooks
# @param [String] 通知したい内容
# @return [Integer] 成功した場合は 0、失敗は 1
def notify(text)
	return Slack::Notifier.new(ENV['WEBHOOK_URL']).ping(text)
end

# HTTP ステータスコードを取得する
# @param [String] チェックしたい URI
# @return [Integer] HTTP ステータスコード
def get_status_code(uri)
	timeout(10){ Net::HTTP.get_response(URI.parse(uri)).code }
end
