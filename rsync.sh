#!/bin/bash

cd /srv/www/DestinationFolder

mkdir -p ~/rsync/logs
mkdir -p ~/rsync/scripts

# timestamp=$(date +%Y%m%d)
timestamp=$(date +%Y%m%d-%H%M)
logfile=$(hostname)_${timestamp}_all.log

ln -sf ~/rsync/logs/$logfile ~/rsync/logs/latest.log

# echo "rsync started, please wait till the next email." |  mail -v -s "Rsync started: $timestamp" user@email.com

rsync -av --delete . ServerHost:/srv/www/DestinationFolder/. | tee ~/rsync/logs/$logfile


cd ~/rsync/logs/
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" > email_summary
date >> email_summary
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> email_summary
ls -lt | head -n 20 >> email_summary
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> email_summary
tail -n 50 latest.log >> email_summary
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> email_summary
timestamp=$(date +%Y%m%d-%H%M)
cat email_summary | mail -s "Rsync completed: $timestamp" emailAddress@com.cn
