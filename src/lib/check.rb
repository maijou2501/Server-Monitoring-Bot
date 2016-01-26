require 'net/http'
require 'net/ping'
require "uri"

# 監視対象をチェックする
# @version 1.1
# @author kyohei ito
class Check
	HTTP_OK="200"

	attr_accessor :addr, :proto, :time_out

	def initialize
		@addr     = nil
		@proto    = "HTTP"
		@time_out  = 5
		@flag     = false
	end

	# 指定アドレスの疎通を確認する
	# @return [Integer] 疎通成功した場合は 0, その他は nil
	def exec
		return STDERR.print("Check Address is undifined.") unless @addr

		case @proto
		when "ICMP"
			ping
		when "HTTP"
			unless ( URI.split(@addr).first == 'http' rescue false )
				STDERR.print("Format is wrong : #{@addr}")
			else
				get_status_code == HTTP_OK ? 0 : nil
			end
		else
			STDERR.print("Set protcol is invalid : #{@proto}")
		end
	end

	private

	# 指定ホストの ping 疎通を確認する
	# @return [Integer] 疎通成功した場合は 0, その他は nil
	# @note ping なので宛先はホスト名指定
	def ping
		pingmon = Net::Ping::External.new(@addr)
		pingmon.timeout = @time_out
		pingmon.ping ? 0 : nil
	end

	# 指定URLのHTTPリクエストを行い、レスポンスのステータスコードから疎通を確認する
	# @return [Integer] 疎通成功した場合は 0, その他は nil
	# @note HTTPリクエストなので宛先はURL指定
	def get_status_code
		unless @time_out.is_a?(Integer)
			STDERR.print("Not Integer : #{time_out}")
		else
			begin
				timeout(@time_out){ Net::HTTP.get_response(URI.parse(@addr)).code }
			rescue Timeout::Error => ex
				STDERR.print("Timeout error : #{ex}")
			rescue => ex
				STDERR.print("Error occurred : #{ex}")
			end
		end
	end
end
