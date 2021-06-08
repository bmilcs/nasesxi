#!/bin/sh
# Command-line parameters: --none--
# Gracefully powers down all guest virtual machines in the FreeNAS datastores

mypath="$( cd -- "$(dirname "")" >/dev/null 2>&1 ; pwd -P )"
. "$mypath"/host.config

logfile="${logdir}"/esxi-stop-all-vms.log

echo "$(date): Shut down virtual machines on ESXi host ${esxihost}, FreeNAS server ${freenashost}" | tee ${logfile}

for datastore in $datastores; do
  "$mypath"/stop-all-datastore-vms.sh root "${esxihost}" "${datastore}" >> "${logfile}"
done

