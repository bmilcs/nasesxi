#!/bin/sh
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ESXI STOP VMS [./stop-vm.sh]

if [ $# -ne 1 ]; then
  echo "$0: error! Not enough arguments"
  echo "Usage is: $0 user_id esxi_host_name vmx_filename"
  echo "Only specify the vmx basefilename; leave off the '.vmx' extension"
  exit 1
fi

mypath="$(dirname "$(realpath "$0")")" ; . "$mypath/config"
vmxname=$1

guestvmids=$(ssh "${esxiuser}"@"${esxihost}" vim-cmd vmsvc/getallvms \
  | grep "/${vmxname}.vmx" | awk '$1 ~ /^[0-9]+$/ {print $1}')

_e "$(date): $0 ${esxiuser}@${esxihost} vmx=${vmxname}.vmx"

for guestvmid in $guestvmids; do
  shutdown_guest_vm "$guestvmid"
done

