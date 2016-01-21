require 'rubygems'
require 'sinatra'
require_relative './tweet.rb'
get '/' do
	  "under construction"
end
get '/random_tweet' do
  Tweet.new.daily_tweet  # 動作チェックが終わったらコメントアウトすること
end
