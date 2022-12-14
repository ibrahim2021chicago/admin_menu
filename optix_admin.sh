#!/bin/bash

clear

. optix_admin.config

# OPTIX Server Admin
OptixServerAdmin () {
    clear
    echo "
OPTIX Server Administration
---------------------------

`hostname`
DR Site: $DRSite
"

    local PS3='Choose an option: '
    local options=("Grep OPTIX Process (OAS)" "Start OPTIX Server (OAS)" "Stop OPTIX Server (OAS)" "Back to main menu")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "Grep OPTIX Process (OAS)")
                ps_out=`ps -ef | grep oas | grep -v grep`;
                if [[ "$ps_out" != "" ]];then
                    echo "$ps_out"
                else
                    echo "Service is not running"
                fi
		        echo""
		        ;;
            "Start OPTIX Server (OAS)")
                sudo -u optix $optix_service/start.optix;
                test $? -eq 0 && echo "Service started successfully" || echo "Service couldn't be started"
		        echo""
		        ;;
            "Stop OPTIX Server (OAS)")
                sudo -u optix $optix_service/stop.optix;
                test $? -eq 0 && echo "Service stopped successfully" || echo "Service couldn't be stopped"
		        echo""
		        ;;
            "Back to main menu")
                exec "$0"
                ;;
            *) echo "Invalid option $REPLY"
		        echo""
		        ;;
        esac
    done
}

# Mail Extractor Process Admin
MailExtractorProcessAdmin () {
    clear
    echo "
Mail Extractor Process Administration
-------------------------------------

`hostname`
DR Site: $DRSite
"
    local PS3='Choose an option: '
    local options=("Grep Mail Extractor Process" "Start Mail Extractor Server" "Stop Mail Extractor Server" "Back to main menu")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "Grep Mail Extractor Process")
                ps_out=`ps -ef | grep dailywork-config | grep -v grep`;
                if [[ "$ps_out" != "" ]];then
                    echo "$ps_out"
                else
                    echo "Service is not running"
                fi
                echo ""
                ;;
            "Start Mail Extractor Server")
                sudo -u optix $mail_extractor/runDailyWorkMailDir.sh;
                test $? -eq 0 && echo "Service started successfully" || echo "Service couldn't be started"
                echo ""
                ;;
            "Stop Mail Extractor Server")
                sudo -u optix kill $(ps aux | grep 'dailywork-config' | grep -v grep | awk '{print $2}');
                test $? -eq 0 && echo "Service stopped successfully" || echo "Service couldn't be stopped"
                echo ""
                ;;
            "Back to main menu")
                exec "$0"
                ;;
            *) echo "invalid option $REPLY"
                echo ""
                ;;
        esac
    done
}

# Apache Web Server Admin
ApacheWebServerAdmin () {
    clear
    echo "
Apache Web Server Administration
--------------------------------

`hostname`
DR Site: $DRSite
"
    local PS3='Choose an option: '
    local options=("Grep Apache Process (http)" "Start Apache Server (http)" "Stop Apache Server (http)" "Back to main menu")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "Grep Apache Process (http)")
                ps_out=`ps -ef | grep http | grep -v grep`;
                if [[ "$ps_out" != "" ]];then
                    echo "$ps_out"
                else
                    echo "Service is not running"
                fi
                echo ""
                ;;
            "Start Apache Server (http)")
                sudo -u optix $apachectl/apachectl unsecure start;
                test $? -eq 0 && echo "Service started successfully" || echo "Service couldn't be started"
                echo ""
                ;;
            "Stop Apache Server (http)")
                sudo -u optix $apachectl/apachectl unsecure stop;
                test $? -eq 0 && echo "Service stopped successfully" || echo "Service couldn't be stopped"
                echo ""
                ;;
            "Back to main menu")
                exec "$0"
                ;;
            *) echo "invalid option $REPLY"
                echo ""
                ;;
        esac
    done
}

# DR State Admin
DRStateAdmin () {
    clear
    echo "
DR State Administration
-----------------------

`hostname`
DR Site: $DRSite
"
    local PS3='Choose an option: '
    local options=("Show Current State" "Set to Active" "Set to Standby" "Show last known state" "Back to main menu")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "Show Current State")
                echo `sudo -u optix $dr_state/get_dr_state`
                echo ""
                ;;
            "Set to Active")
                echo `sudo -u optix $dr_state/set_dr_state active`
                echo ""
                ;;
            "Set to Standby")
                echo `sudo -u optix $dr_state/set_dr_state standby`
                echo ""
                ;;
            "Show last known state")
                echo `more $dr_logs/last_known_state`
                echo ""
                ;;
            "Back to main menu")
                exec "$0"
                ;;
            *) echo "invalid option $REPLY"
                echo ""
                ;;
        esac
    done
}

# Show Support Notes
ShowSupportNotes () {
    clear
    echo "
Support Notes
-------------

`hostname`
DR Site: $DRSite
"
    local PS3='Choose an option: '
    local options=("Show Support Notes" "Back to main menu")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "Show Support Notes")
                echo "Not available!"
                echo ""
                ;;
            "Back to main menu")
                exec "$0"
                ;;
            *) echo "invalid option $REPLY"
                echo ""
                ;;
        esac
    done
}

if [[ $Dev_WTC =~ `hostname` ]];
then DRSite="Dev_WTC"
elif [[ $Stage_WTC =~ `hostname` ]];
then DRSite="Stage_WTC"
elif [[ $Stage_EDC =~ `hostname` ]];
then DRSite="Stage_EDC"
elif [[ $Prod_WTC =~ `hostname` ]];
then DRSite="Prod_WTC"
elif [[ $Prod_EDC =~ `hostname` ]];
then DRSite="Prod_EDC"
else DRSite="undefined"
fi

#sysinfo
echo "
OPTIX Administration Menu
-------------------------

`hostname`
DR Site: $DRSite
"
#main_menu
PS3='Choose an option: '
options=("OPTIX Server Admin" "Mail Extractor Process Admin" "Apache Web Server Admin" "DR State Admin" "Show Support Notes" "exit")
COLUMNS=12
select opt in "${options[@]}"
do
    case $opt in
        "OPTIX Server Admin")
            OptixServerAdmin
            ;;
        "Mail Extractor Process Admin")
            MailExtractorProcessAdmin
            ;;
        "Apache Web Server Admin")
            ApacheWebServerAdmin
            ;;
        "DR State Admin")
            DRStateAdmin
            ;;
        "Show Support Notes")
            ShowSupportNotes
            ;;
        "exit")
            exit
            ;;
        *) echo "invalid option $REPLY"
            echo ""
            ;;
    esac
done