#/bin/bash

root_db_pw=$1
new_db_name=$2
new_db_user=$3
new_db_pw=$4

sudo mysql -u root -p${root_db_pw} -e "CREATE DATABASE $new_db_name CHARACTER SET utf8 COLLATE utf8_bin;"
sudo mysql -u ${new_db_user} -p${new_db_pw} -e "GRANT ALL PRIVILEGES ON new_db.* TO "'"$new_db_user"'"@'localhost' IDENTIFIED BY "'"$new_db_pw"'";"


 

