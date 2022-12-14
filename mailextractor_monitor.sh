#!/bin/bash

host=`hostname -f`
ps_out=`ps -ef | grep dailywork-config | grep -v grep`;

if [[ "$ps_out" != "" ]];then
echo "Service is running"
else
sudo -u optix $mail_extractor/runDailyWorkMailDir.sh
echo "Mail Extractor service at $host wasn't running and has been restarted." | mail -s "$subject" $email
fi
