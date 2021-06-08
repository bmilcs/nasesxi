#!/bin/sh
################################################################################
#
# Command-line parameters: --none--
#
# Forces a FreeNAS VM's ESXi host to rescan its datastores
#
################################################################################

. "$( cd -- "$(dirname "")" >/dev/null 2>&1 ; pwd -P )"/host.config

logfile="${logdir}/esxi-rescan-datastores.log"

echo "$(date): Forcing datastore rescan on ESXi host ${esxihost}" | tee -a "${logfile}"

ssh root@"${esxihost}" esxcli storage core adapter rescan --all
