require 'spec_helper'

describe port(80) do
  	it { should be_listening }
end

describe port(443) do
  	it { should be_listening }
end

describe service('httpd') do
  	it { should be_enabled }
  	it { should be_running }
end

describe command("curl -k https://localhost/") do
	its(:stdout) { should contain('Hello World') }
end
