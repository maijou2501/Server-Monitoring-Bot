require 'clockwork'
include Clockwork
require_relative '../lib/task.rb'

handler Task.new.exec

# 環境変数CHECK_INTERVALが定義されていなければ、デフォルトで3時間毎にチェックを行う。
time = ENV["CHECK_INTERVAL"] || 3
every( time.to_i.hours, "#{time}.hours.job" )
