#!/bin/bash
echo "

OPTIX Administration menu
-------------------------
"
echo `hostname`
echo "DR Site: WTC

1. OPTIX Server Admin
2. Mail Extractor Process Admin
3. Apache Web Server Admin
4. DR State Admin
5. Show Support Notes
Choose an option [1-5]: "
read option
case $option in
1)OPTIX Server Admin;;
esac
