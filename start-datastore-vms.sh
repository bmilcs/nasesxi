#!/bin/sh

mypath="$( cd -- "$(dirname "")" >/dev/null 2>&1 ; pwd -P )"
. "$mypath"/host.config

is_active=0
logfile="${logdir}/start-datastore-vms.log"
waitdelay=30

if [ $is_active -ne 0 ]; then
  echo "Pausing $waitdelay seconds before starting virtual machines..." >> $logfile
  sleep $waitdelay
  
# if [ "${freenashost}" = "boomer" ]; then
#   /mnt/tank/systems/scripts/start-vm.sh root felix adonis  >> "$logfile"
#   /mnt/tank/systems/scripts/start-vm.sh root felix aphrodite  >> "$logfile"
# fi
fi

