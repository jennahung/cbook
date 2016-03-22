#
# Cookbook Name:: deploy_war
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe tomcat7

execute "stop tomcat" do
  user "root"
  command "service tomcat stop"
end

Dir[ "/home/tomcat/tomcat7/webapps/*" ].each do |path|
  file "/home/tomcat/tomcat7/webapps/.war" do
    action :delete
  end if File.file?(path)

  directory "/home/tomcat/tomcat7/webapps/billing" do
    path path
    action :delete
    recursive true
  end if File.directory?(path)
end

if node.chef_environment == "prod"
  execute "get artifact from S3 bucket" do
    command "/usr/local/bin/s3cmd --config /root/.s3cfg get s3://artifacts/war/prod/#{node[:deploy_war][:bbilling_prod_artifact]}.war /home/tomcat/tomcat7/webapps/billing.war"
  end
else
  execute "get artifact from S3 bucket" do
    command "/usr/local/bin/s3cmd --config /root/.s3cfg get s3://artifacts/war/dev/#{node[:deploy_war][:bbilling_latest_artifact]}.war /home/tomcat/tomcat7/webapps/billing.war"
  end
end

file "/home/tomcat/tomcat7/webapps/billing.war" do
  owner "tomcat"
  group "tomcat"
  mode "0644"
  action :touch
end

execute "start tomcat" do
  user "root"
  command "service tomcat start"
end


