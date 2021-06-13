#!/bin/sh
# Command-line parameters: --none--
# Forces a FreeNAS VM's ESXi host to rescan its datastores

mypath="$( cd -- "$(dirname "")" >/dev/null 2>&1 ; pwd -P )"
. "$mypath"/host.config

logfile="${logdir}/rescan-datastores.log"

echo "$(date): Forcing datastore rescan on ESXi host ${esxihost}" | tee -a "${logfile}"

ssh root@"${esxihost}" esxcli storage core adapter rescan --all
