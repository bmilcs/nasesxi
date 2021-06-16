#!/bin/sh
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ESXI STOP ALL VMS [./stop-all-vms.sh]
#────────────────────────────────────────────────────────────

# gracefully powers down all guest virtual machines in the freenas datastores

mypath="$( cd -- "$(dirname "")" >/dev/null 2>&1 ; pwd -P )"
. "$mypath"/config

logfile="${logdir}"/esxi-stop-all-vms.log

echo "$(date): Shut down virtual machines on ESXi host ${esxihost}, FreeNAS server ${freenashost}" | tee ${logfile}
echo "datastores: $datastores"

for datastore in $datastores; do
  "$mypath"/stop-all-datastore-vms.sh root "${esxihost}" "${datastore}" >> "${logfile}"
done

