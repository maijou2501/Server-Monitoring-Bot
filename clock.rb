require 'clockwork'
include Clockwork
require_relative './task.rb'

handler do |job|
	Task.new.exec
end

# 環境変数CHECK_INTERVAL が定義されていなければ、デフォルトで3時間毎にチェックを行う。
time = ENV["CHECK_INTERVAL"] || "3.hours"
every( time.to_i, time + '.job' )
