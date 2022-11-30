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
                break
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
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

#main_menu
PS3='Choose an option: '
options=("OPTIX Server Admin" "Mail Extractor Process Admin" "Apache Web Server Admin" "DR State Admin" "Show Support Notes" "exit")
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