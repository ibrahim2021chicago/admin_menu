#!/bin/bash

clear

# OPTIX Server Admin
OptixServerAdmin () {
    local PS3='Choose an option: '
    local options=("Grep OPTIX Process (OAS)" "Start OPTIX Server (OAS)" "Stop OPTIX Server (OAS)" "Back to main menu")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "Grep OPTIX Process (OAS)")
                echo `ps -ef | grep oas`
                ;;
            "Start OPTIX Server (OAS)")
                echo "sudo -u optix /opt/software/optix/optix6/bin/start.optix"
                ;;
            "Stop OPTIX Server (OAS)")
                echo "sudo -u optix /opt/software/optix/optix6/bin/start.optix"
                ;;
            "Back to main menu")
                exec "$0"
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# Mail Extractor Process Admin
MailExtractorProcessAdmin () {
    local PS3='Choose an option: '
    local options=("Grep Mail Extractor Process" "Start Mail Extractor Server" "Stop Mail Extractor Server" "Back to main menu")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "Grep Mail Extractor Process")
                echo `ps -ef | grep oas`
                ;;
            "Start Mail Extractor Server")
                echo "sudo -u optix /opt/software/optix/optix6/bin/runDailyWorkMailDir.sh"
                ;;
            "Stop Mail Extractor Server")
                echo "sudo -u optix kill <process id>"
                ;;
            "Back to main menu")
                exec "$0"
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# Apache Web Server Admin
ApacheWebServerAdmin () {
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
                echo "sudo -u optix /opt/fedex/optix/bin/apachectl unsecure start"
                ;;
            "Stop Apache Server (http)")
                echo "sudo -u optix /opt/fedex/optix/bin/apachectl unsecure stop"
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
                echo "sudo -u optix /opt/fedex/DR/scripts/set_dr_state active"
                ;;
            "Set to Standby")
                echo "sudo -u optix /opt/fedex/DR/scripts/set_dr_state standby"
                ;;
            "Show last known State")
                echo "more /var/fedex/DR/logs/last_known_state"
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

#sysinfo
echo "
OPTIX Administration Menu
-------------------------

`hostname`
DR Site: WTC
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