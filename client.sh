#!/bin/bash

#sudo yum -y upgrade 
sudo yum install -y vim git wget

redhat_v=$(cat /etc/redhat-release | grep -o 'release [^ ]' | sed 's/release //')

chef-solo -v > /dev/null 2>&1 

if [ $? != 0 ]; then
   rm *.rpm*
   if [ $redhat_v == "7" ]; then
      wget https://packages.chef.io/stable/el/7/chefdk-0.17.17-1.el7.x86_64.rpm
      sudo rpm -Uvh chefdk-0.17.17-1.el7.x86_64.rpm
   elif [ $redhat_v == "6" ]; then
      wget https://packages.chef.io/stable/el/6/chefdk-0.17.17-1.el6.x86_64.rpm
      sudo rpm -Uvh chefdk-0.17.17-1.el6.x86_64.rpm
   else
      echo "Is this a readhat OS?"
      exit 2
   fi
fi 

rm -rf chefdk*.rpm

chef-solo -v > /dev/null 2>&1

if [ $? = 0 ]; then
   echo "`chef-solo -v` installed"
else
   echo "chef clent install fail"
   exit 3
fi

host=`hostname`

rm -rf chef-repo
git clone https://github.com/jennahung/cbook.git chef-repo
