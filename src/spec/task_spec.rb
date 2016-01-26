require_relative '../lib/task'
require_relative '../spec/spec_helper.rb'

RSpec.describe Task do
	it "return nil(CHECK ADDRESS is undifined.)" do
		expect(Task.new.exec).to eq nil
	end

end
