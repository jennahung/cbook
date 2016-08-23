#!/bin/sh

wiki_home=$1
backup_folder=$2
db_name=$3
db_user=$4
db_pw=$5

DATE=`date '+%y%m%d'`

cd $2
tar czf wiki-$DATE.tar.gz $1
sudo mysqldump $3 -p $4 -p $5 > wiki_db-$DATE.sql 
gzip wiki_db-$DATE.sql

find $2 -type f -mtime +2 -exec rm {} \;
