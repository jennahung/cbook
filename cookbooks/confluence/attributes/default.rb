
default['confluence']['java']['java_home']  = '/usr/java/8.101'

default['confluence']['home_path']      = '/cd/wiki/wiki-data'
default['confluence']['install_path']   = '/cd/wiki/wiki-5103'
default['confluence']['user']           = 'atlassian'
default['confluence']['version']        = '5.10.3'
default['confluence']['url_base']       = 'http://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence'
default['confluence']['url']      = "#{node['confluence']['url_base']}-#{node['confluence']['version']}.tar.gz"
default['confluence']['checksum'] =
  case node['confluence']['version']
  when '5.10.3' then 'd6b202340d4e7329ae1a859dd23d96b1'
  end

default['confluence']['database']['host']     = 'localhost'
default['confluence']['database']['name']     = 'iad_wiki'
default['confluence']['database']['password'] = 'Wiki0816_db!'
default['confluence']['database']['port']     = 3306
default['confluence']['database']['type']     = 'mysql'
default['confluence']['database']['user']     = 'wiki_db'
default['confluence']['database']['root_password'] = 'rootT!0816'

default['confluence']['jvm']['minimum_memory']  = '1024m'
default['confluence']['jvm']['maximum_memory']  = '4096m'
default['confluence']['jvm']['maximum_permsize'] = '512m'

default['confluence']['tomcat']['shutdown_port']= '9005'
default['confluence']['tomcat']['port']         = '23420'
default['confluence']['tomcat']['ssl_port']     = '8443'
default['confluence']['tomcat']['context_path']= '/kiwi'
default['confluence']['tomcat']['proxyserver_name'] = 'iadwiki.apple.com'

default['confluence']['java']['source_base'] = 'http://download.oracle.com/otn-pub/java/jdk/8u101-b13/'
default['confluence']['java']['tar_name']= 'jdk-8u101'
default['confluence']['java']['url']         = "#{node['confluence']['java']['source_base']}/#{node['confluence']['java']['tar_name']}-linux-x64.tar.gz"
default['confluence']['java']['install_home']= '/usr/java'
default['confluence']['java']['version']= '8.101'
default['confluence']['java']['jdk']= 'jdk1.8.0_101'

