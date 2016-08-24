#
# Cookbook Name:: confluence
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


wget http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm

mysql_service 'default' do
  initial_root_password node['confluence']['database']['root_password']
  action [:create, :start]
end
