require "rubygems"
require "slack-notifier"

Slack::Notifier.new(ENV['WEBHOOK_URL']).ping("Hello World")
