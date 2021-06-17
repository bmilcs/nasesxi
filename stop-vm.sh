#!/bin/sh
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ESXI STOP VMS [./stop-vm.sh]
#────────────────────────────────────────────────────────────
# command-line parameters: user_id esxi_host_name vmx_base_filename
#
# stop guest virtual machine with vmx file (vmx_base_filename'.vmx') on remote
# vmware esxi server (esxi_host_name) using given user credentials (user_id)
#
################################################################################

# Check for invocation errors

if [ $# -ne 1 ]; then
  echo "$0: error! Not enough arguments"
  echo "Usage is: $0 user_id esxi_host_name vmx_filename"
  echo "Only specify the vmx basefilename; leave off the '.vmx' extension"
  exit 1
fi

mypath="$(dirname "$(realpath "$0")")" ; . "$mypath/config"

set -x
vmxname=$1

guestvmids=$(ssh "${esxiuser}"@"${esxihost}" vim-cmd vmsvc/getallvms | grep "/${vmxname}.vmx" | awk '$1 ~ /^[0-9]+$/ {print $1}')

echo "$(date): $0 ${esxiuser}@${esxihost} vmx=${vmxname}.vmx"

for guestvmid in $guestvmids; do
  shutdown_guest_vm "$guestvmid"
done
set +x

