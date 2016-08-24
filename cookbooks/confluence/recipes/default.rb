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
#service 'mysqld' do
#  action [:enable, :restart]
#end
# 
#template "/etc/my.cnf" do
#  source 'wiki_db_settings.erb'
#  owner "root"
#  mode '0644'
#end

# configuration
template "#{node['confluence']['install_path']}/confluence/WEB-INF/classes/confluence-init.properties" do
  source 'confluence-init.properties.erb'
  owner node['confluence']['user']
  mode '0644'
end

# backup
template "#{node['confluence']['backup_path']}/backup.sh" do
  source 'backup.sh.erb'
  owner node['confluence']['user']
  mode '0755'
end

cron 'backup.sh' do
  minute '0'
  hour '3'
  weekday '1,4'
  command "#{node['confluence']['backup_path']}/backup.sh"
  user "#{node['confluence']['user']}"
  only_if {File.exists?("#{node['confluence']['backup_path']}/backup.sh")}
end

# tomcat
template "#{node['confluence']['install_path']}/bin/setenv.sh" do
  source 'setenv.sh.erb'
  owner node['confluence']['user']
  mode '0755'
end

template "#{node['confluence']['install_path']}/conf/server.xml" do
  source 'server.xml.erb'
  owner node['confluence']['user']
  mode '0640'
end

template '/etc/init.d/confluence' do
  source 'confluence.init.erb'
  mode '0755'
  notifies :restart, 'service[confluence]', :delayed
end

# service
service 'mysqld' do
  supports :status => true
  action :start
end

service 'confluence' do
  supports :status => true
  action :start
end

