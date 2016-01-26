require_relative '../lib/slack'
require_relative '../spec/spec_helper.rb'

RSpec.describe Slack do
	it "return nil('WEBHOOK_URL' is undefined.)" do
		expect(slack("test")).to eq nil
	end
end
