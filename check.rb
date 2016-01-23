require 'net/http'
require 'net/ping'
require "uri"

# 指定ホストの ping 疎通を確認する
# @param [String] host チェックしたいホスト名
# @return [Boolean] 成功した場合は TRUE
# @note タイムアウトは環境変数CHECK_TIMEOUTで設定。未定義なら "5" 秒の設定になる
# @example ホスト名を引数に、論理型を返す
#   ping("example.com") #=> TRUE
def ping(host)
	pingmon = Net::Ping::External.new(host)
	pingmon.timeout = ENV["CHECK_TIMEOUT"] || 5
	if pingmon.ping?
		TRUE
	else
		FALSE
	end
end

# 指定URIのHTTPステータスコードを取得する
# @param [String] uri チェックしたいURI
# @return [Integer] HTTPステータスコード
# @note タイムアウトは環境変数CHECK_TIMEOUTで設定。未定義なら "5" 秒の設定になる
# @example URIを引数に、ステータスコードを返す
#   get_status_code("http://example.com") #=> "200"
def get_status_code(uri)
	time = ENV["CHECK_TIMEOUT"] || 5
	timeout(time){ Net::HTTP.get_response(URI.parse(uri)).code }
end
