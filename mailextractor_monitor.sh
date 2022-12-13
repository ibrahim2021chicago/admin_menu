#!/bin/bash

email=mohammed.khaleel.osv@fedex.com
host=`hostname -f`
ps_out=`ps -ef | grep dailywork-config | grep -v grep`;
subject="Mail Extractor service alert"

if [[ "$ps_out" != "" ]];then
echo "Service is running"
else
sudo -u optix /opt/software/optix/optix6/bin/runDailyWorkMailDir.sh
echo "Mail Extractor service at $host wasn't running and has been restarted." | mail -s "$subject" $email
fi
