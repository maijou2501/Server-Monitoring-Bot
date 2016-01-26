require_relative '../lib/check'
require_relative '../spec/spec_helper.rb'

RSpec.describe Check do
	it "return nil(CHECK ADDRESS is undifined.)" do
		expect(Check.new.exec).to eq nil
	end
	
	it "return nil(CHECK PROTOCOL is invalid setting.)" do
		proto = Check.new
		proto.addr = "http://example.com"
		proto.proto = "SNMP"
		expect(proto.exec).to eq nil
	end

	it "return 0  (HTTP_OK)" do
		check = Check.new
		check.addr = "http://example.com"
		expect(check.exec).to eq 0
	end

	it "return nil(HTTP_204)" do
		addr_204 = Check.new
		addr_204.addr = "http://google.co.jp/generate_204"
		expect(addr_204.exec).to eq nil
	end

	it "return nil(time_out error)" do
		time_out = Check.new
		time_out.addr = "http://hogefugapiyo.com"
		time_out.time_out = 1
		expect(time_out.exec).to eq nil
	end

	it "return nil(time_out is not Integer)" do
		time_out_int = Check.new
		time_out_int.time_out = "test"
		time_out_int.addr = "http://example.com"
		expect(time_out_int.exec).to eq nil
	end

	it "return nil(host error)" do
		http_host = Check.new
		http_host.addr = "example.com"
		expect(http_host.exec).to eq nil
	end

	it "return nil(URI error)" do
		ftp_host = Check.new
		ftp_host.addr = "ftp://example.com"
		expect(ftp_host.exec).to eq nil
	end

	it "return 0(ping : OK)" do
		ping_ok = Check.new
		ping_ok.addr = "example.com"
		ping_ok.proto = "ICMP"
		expect(ping_ok.exec).to eq 0
	end

	it "return nil(ping : URI error)" do
		ping_uri = Check.new
		ping_uri.addr = "htttp://example.com"
		ping_uri.proto = "ICMP"
		expect(ping_uri.exec).to eq nil
	end

	it "return nil(ping : time_out error)" do
		ping_time_out = Check.new
		ping_time_out.addr = "hogefugapiyo.com"
		ping_time_out.proto = "ICMP"
		ping_time_out.time_out = 1
		expect(ping_time_out.exec).to eq nil
	end

end
