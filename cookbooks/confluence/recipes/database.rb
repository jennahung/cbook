#
# Cookbook Name:: confluence
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


mysql_client 'default' do
  action :create
end

mysql_service 'default' do
  initial_root_password node['confluence']['database']['root_password']
  action [:create, :start]
end
