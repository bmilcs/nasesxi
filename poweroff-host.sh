#!/bin/sh
# Command-line parameters: --none--
# Sends the poweroff command to a FreeNAS server VM's ESXi host

mypath="$( cd -- "$(dirname "")" >/dev/null 2>&1 ; pwd -P )"
. "$mypath"/host.config

logfile="${logdir}/esxi-poweroff-host.log"

echo "$(date): $0 sending poweroff command to ESXi host ${esxihost}" | tee -a "$logfile"

ssh root@"${esxihost}" poweroff
