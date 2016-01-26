require_relative '../lib/task'
require_relative '../spec/spec_helper.rb'

RSpec.describe Tweet do
	it "return nil(No Tweet text)" do
		expect(Tweet.new.tweet(nil)).to eq nil
	end

	it "return nil(Some Twitter API key are NOT exported.)" do
		expect(Tweet.new.tweet("test")).to eq nil
	end

end
