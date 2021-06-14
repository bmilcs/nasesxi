#!/bin/sh

mypath="$( cd -- "$(dirname "")" >/dev/null 2>&1 ; pwd -P )"
. "$mypath"/host.config

#is_active=0
logfile="${logdir}/start-datastore-vms.log"
waitdelay=30

#if [ $is_active -ne 0 ]; then
  echo "Pausing $waitdelay seconds before starting virtual machines..." >> "$logfile"
  sleep $waitdelay
  
    "$mypath"/start-vm.sh Docker >> "$logfile"
    "$mypath"/start-vm.sh Plex  >> "$logfile"
    "$mypath"/start-vm.sh mPi >> "$logfile"
    "$mypath"/start-vm.sh kPi >> "$logfile"
    "$mypath"/start-vm.sh MPD >> "$logfile"
    "$mypath"/start-vm.sh DC1  >> "$logfile"
    "$mypath"/start-vm.sh Guacamole  >> "$logfile"
    "$mypath"/start-vm.sh Security  >> "$logfile"
    "$mypath"/start-vm.sh UNMS  >> "$logfile"
    "$mypath"/start-vm.sh Backup  >> "$logfile"
#fi

