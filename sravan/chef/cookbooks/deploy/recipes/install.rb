package ['httpd', 'mod_ssl'] do
        action :install
end

cookbook_file "#{node[:conf_dir]}/httpd.conf" do
	source 'httpd.conf'
  	owner 'apache'
  	group 'apache'
  	mode '0755'
  	action :create
end

directory "#{node[:ssl_dir]}" do
  	owner 'apache'
  	group 'apache'
 	mode '0755'
  	action :create
end

cookbook_file "#{node[:ssl_dir]}/site.crt" do
        source 'site.crt'
        owner 'apache'
        group 'apache'
        mode '0755'
        action :create
end

cookbook_file "#{node[:ssl_dir]}/site.key" do
	source 'site.key'
	owner 'apache'
        group 'apache'
        mode '0755'
        action :create
end

cookbook_file "#{node[:data_dir]}/index.html" do
        source 'index.html'
        owner 'apache'
        group 'apache'
        mode '0755'
        action :create
end

service 'httpd' do
        action [ :enable, :start ]
end
