require 'clockwork'
include Clockwork
require_relative './task.rb'

handler do |job|
	Task.new.exec
end

every(3.hours, '3hours.job')
