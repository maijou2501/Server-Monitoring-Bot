require 'net/http'
require 'net/ping'
require "rubygems"
require "slack-notifier"
require "uri"

# 指定ホストの ping 疎通を確認する
# @param [String] host チェックしたいホスト名
# @return [Boolean] 成功した場合は TRUE
# @example ホスト名を引数に、Bool変数を返す
#   ping("example.com") #=> TRUE
def ping(host)
	pingmon = Net::Ping::External.new(host)
	if pingmon.ping?
		TRUE
	else
		FALSE
	end
end

# slack, Incoming WebHooks
# @see https://api.slack.com/incoming-webhooks
# @param [String] text 通知したい内容
# @return [Integer] 成功した場合は 0、失敗は 1
def notify(text)
	return Slack::Notifier.new(ENV['WEBHOOK_URL']).ping(text)
end

# 指定URIのHTTPステータスコードを取得する
# @param [String] uri チェックしたいURI
# @return [Integer] HTTPステータスコード
# @note タイムアウトは10秒設定
# @example URIを引数に、ステータスコードを返す
#   get_status_code("http://example.com") #=> "200"
def get_status_code(uri)
	timeout(10){ Net::HTTP.get_response(URI.parse(uri)).code }
end
