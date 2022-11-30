#!/bin/bash

# OPTIX Server Admin
OptixServerAdmin () {
  local PS3='Choose an option: '
  local options=("Grep OPTIX Process" "Start OPTIX Server" "Stop OPTIX Server" "Back to main menu")
  local opt
  select opt in "${options[@]}"
  do
      case $opt in
          "Grep OPTIX Process")
              echo `ps -ef | grep oas`
              ;;
          "quit")
              return
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
            echo ""
            ;;
        "exit")
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done