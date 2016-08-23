#/bin/bash

backup_db=1
new_db=$2
new_db_user=$3
new_db_pw=$4

sudo mysql $new_db -u $new_db_user -p${new_db_pw} < $backup_db
