#
# Cookbook Name:: confluence
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#


# db

service 'mysql' do
  action :start
end
 
template "/etc/my.conf" do
  source 'wiki_db_settings.erb'
  owner "root"
  mode '0644'
  notifies :restart, 'service[mysql]', :delayed
end

# configuration
template "#{node['confluence']['install_path']}/confluence/WEB-INF/classes/confluence-init.properties" do
  source 'confluence-init.properties.erb'
  owner node['confluence']['user']
  mode '0644'
  notifies :restart, 'service[confluence]', :delayed
end

# tomcat
template "#{node['confluence']['install_path']}/bin/setenv.sh" do
  source 'setenv.sh.erb'
  owner node['confluence']['user']
  mode '0755'
  notifies :restart, 'service[confluence]', :delayed
end

template "#{node['confluence']['install_path']}/conf/server.xml" do
  source 'server.xml.erb'
  owner node['confluence']['user']
  mode '0640'
  notifies :restart, 'service[confluence]', :delayed
end

template '/etc/init.d/confluence' do
  source 'confluence.init.erb'
  mode '0755'
  notifies :restart, 'service[confluence]', :delayed
end

# service
service 'confluence' do
  supports :status => true, :restart => true
  action :enable
  subscribes :restart, 'java_ark[jdk]'
end


