#!/bin/bash

clear

. optix_admin.config

# $env Server Admin
OptixServerAdmin () {
    clear
    echo "
$env Server Administration
---------------------------

`hostname`
DR Site: $DRSite
"

    local PS3='Choose an option: '
    local options=("Grep $env Process (OAS)" "Start $env Server (OAS)" "Stop $env Server (OAS)" "Back to main menu")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "Grep $env Process (OAS)")
                ps_out=`ps -ef | grep oas | grep -v grep`;
                if [[ "$ps_out" != "" ]];then
                    echo "$ps_out"
                else
                    echo "Service is not running"
                fi
		        echo""
		        ;;
            "Start $env Server (OAS)")
                ${cmd_optix_start[@]};
                test $? -eq 0 && echo "Service started successfully" || echo "Service couldn't be started"
		        echo""
		        ;;
            "Stop $env Server (OAS)")
                ${cmd_optix_stop[@]};
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
                ${cmd_mailextractor_start[@]};
                test $? -eq 0 && echo "Service started successfully" || echo "Service couldn't be started"
                echo ""
                ;;
            "Stop Mail Extractor Server")
		mailextractor_pid=`ps -ef | grep 'dailywork-config' | grep -v grep | awk '{print $2}'`
                sudo -u $user kill $mailextractor_pid;
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
                ${cmd_apachectl_start[@]};
                test $? -eq 0 && echo "Service started successfully" || echo "Service couldn't be started"
                echo ""
                ;;
            "Stop Apache Server (http)")
                ${cmd_apachectl_stop[@]};
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
                ${cmd_get_dr_state[@]};
                echo ""
                ;;
            "Set to Active")
                ${cmd_set_dr_active[@]};
                echo ""
                ;;
            "Set to Standby")
                ${cmd_set_dr_standby[@]};
                echo ""
                ;;
            "Show last known state")
                ${cmd_last_known_state[@]};
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

#sysinfo
echo "
$env Administration Menu
-------------------------

`hostname`
DR Site: $DRSite
"
#main_menu
PS3='Choose an option: '
options=("$env Server Admin" "Mail Extractor Process Admin" "Apache Web Server Admin" "DR State Admin" "Show Support Notes" "exit")
COLUMNS=12
select opt in "${options[@]}"
do
    case $opt in
        "$env Server Admin")
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
