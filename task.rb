require 'clockwork'
include Clockwork
require_relative './tweet.rb'

handler do |job|

	addr = ENV['CHECK_ADDRESS']
	flag = ENV['CHECK_PROTOCOL']

	case flag
	when "ICMP"

		if ping(addr)
			tweet  = ENV['TWEET_SUCCESS']
			notify = "#{addr}, OK"
		else
			tweet  = ENV['TWEET_FAIL']
			notify = "#{addr}, NG"
		end

	else

		if get_status_code(addr) == "200"
			tweet  = ENV['TWEET_SUCCESS']
			notify = "#{addr}, OK"
		else 
			tweet  = ENV['TWEET_FAIL']
			notify = "#{addr}, NG"
		end

	end

	Tweet.new.tweet(tweet)
	notify( notify )

end

every(2.hours, '2hours.job')
