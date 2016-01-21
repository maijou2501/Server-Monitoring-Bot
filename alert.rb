require "date"
require 'net/ping'
require "rubygems"
require "slack-notifier"


$addr = ENV['CHECK_HOST']

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

# 指定ホストの ping 疎通を確認する
# @param [String] 通知したい内容
# @return [Integer] 成功した場合は 0、失敗は 1
def notify(text)
	return Slack::Notifier.new(ENV['WEBHOOK_URL']).ping(text)
end

# main
time = Time.now
if ping(addr)
	notify("#{time}, #{addr}, OK")
else
	return notify(time,", #{addr}, NG")
end
