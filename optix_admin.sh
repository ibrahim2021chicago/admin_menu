#!/bin/bash

clear

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
                echo "`ps -ef | grep oas`"
		        echo""
		        ;;
            "Start OPTIX Server (OAS)")
                sudo -u optix /opt/software/optix/optix6/bin/start.optix;
                echo "Service started successfully"
		        echo""
		        ;;
            "Stop OPTIX Server (OAS)")
                sudo -u optix /opt/software/optix/optix6/bin/stop.optix;
                echo "Service stopped successfully"
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
                echo `ps -ef | grep dailywork-config`
                echo ""
                ;;
            "Start Mail Extractor Server")
                sudo -u optix /opt/software/optix/optix6/bin/runDailyWorkMailDir.sh;
                echo ""
                ;;
            "Stop Mail Extractor Server")
                echo "sudo -u optix kill <process id>"
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
                echo `ps -ef | grep http`
                ;;
            "Start Apache Server (http)")
                echo `sudo -u optix /opt/fedex/optix/bin/apachectl unsecure start`
                ;;
            "Stop Apache Server (http)")
                echo `sudo -u optix /opt/fedex/optix/bin/apachectl unsecure stop`
                ;;
            "Back to main menu")
                exec "$0"
                ;;
            *) echo "invalid option $REPLY";;
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
                echo `sudo -u optix /opt/fedex/DR/scripts/get_dr_state`
                ;;
            "Set to Active")
                echo `sudo -u optix /opt/fedex/DR/scripts/set_dr_state active`
                ;;
            "Set to Standby")
                echo `sudo -u optix /opt/fedex/DR/scripts/set_dr_state standby`
                ;;
            "Show last known state")
                echo `more /var/fedex/DR/logs/last_known_state`
                ;;
            "Back to main menu")
                exec "$0"
                ;;
            *) echo "invalid option $REPLY";;
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
                echo ""
                ;;
            "Back to main menu")
                exec "$0"
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

#optix_hosts
Dev_WTC="iwb22002.ute.fedex.com"
Stage_WTC="vwb22002.ute.fedex.com,vwb22003.ute.fedex.com"
Stage_EDC="vwb22012.ute.fedex.com vwb22013.ute.fedex.com"
Prod_WTC="pwb00217.lhsprod.fedex.com,pwb00218.lhsprod.fedex.com"
Prod_EDC="pwb22021.lhsprod.fedex.com,pwb22022.lhsprod.fedex.com"

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
        *) echo "invalid option $REPLY";;
    esac
done
