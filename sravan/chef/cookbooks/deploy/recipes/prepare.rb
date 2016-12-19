package ['httpd'] do
	action :nothing
end.run_action(:install)

cookbook_file "#{ENV['HOME']}/.ssh/config" do
  	source 'config'
  	owner "#{ENV['USER']}"
 	group "#{ENV['USER']}"
  	mode '0600'
  	action :nothing ## CHEF NOT HONOURING RECIPE ORDER IN DEFAULT.RB
end.run_action(:create) ## THIS FIXES ORDER ISSUE

cookbook_file "#{ENV['HOME']}/.ssh/deployment_key.rsa" do
	source 'deployment_key.rsa'
	owner "#{ENV['USER']}"
        group "#{ENV['USER']}"
  	mode '0600'
	action :nothing
end.run_action(:create)
