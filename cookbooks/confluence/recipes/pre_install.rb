

directory "#{node['confluence']['java']['install_home']}" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute "Install Java" do
  cwd "#{node['confluence']['java']['install_home']}"
  command <<-COMMAND
    rm -rf *jdk*tar.gz
    wget --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" #{node['confluence']['java']['url']}
    tar -zxf #{node['confluence']['java']['tar_name']}-linux-x64.tar.gz
    ln -s #{node['confluence']['java']['jdk']} #{node['confluence']['java']['version']}
  COMMAND
  not_if { ::File.directory?("#{node['confluence']['java']['install_home']}/#{node['confluence']['java']['jdk']}") }
end


execute "Install DB" do
  cwd "/tmp"
  command <<-COMMAND
    rm -rf mysql*.rpm
    wget http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
    sudo rpm -e mysql-community-release
    sudo rpm -ivh mysql57-community-release-el6-7.noarch.rpm
    sudo yum install mysql-community-server
    rm -rf mysql*.rpm
  COMMAND
  not_if { ::File.directory?("/var/lib/mysql") }
end

user node['confluence']['user'] do
  home "/home/#{node['confluence']['user']}"
  shell '/bin/bash'
  supports :manage_home => true
  system true
  action :create
end

directory "#{node['confluence']['home_path']}" do
  owner node['confluence']['user']
  group node['confluence']['user']
  mode 00755
  action :create
  recursive true
end

directory "#{node['confluence']['backup_path']}" do
  owner node['confluence']['user']
  group node['confluence']['user']
  mode 00755
  action :create
  recursive true
end

directory "#{node['confluence']['install_path']}" do
  owner node['confluence']['user']
  group node['confluence']['user']
  mode 00755
  action :create
  recursive true
end

execute "Extracting Confluence #{node['confluence']['version']}" do
  cwd '/tmp'
  command <<-COMMAND
    rm -rf *.gz
    wget #{node['confluence']['url']}
    tar -zxf atlassian-confluence-#{node['confluence']['version']}.tar.gz
    mv atlassian-confluence-#{node['confluence']['version']}/* #{node['confluence']['install_path']}
    chown -R #{node['confluence']['user']}.#{node['confluence']['user']} #{node['confluence']['install_path']}
  COMMAND
  not_if { ::File.directory?("#{node['confluence']['install_path']}/conf") }
end
