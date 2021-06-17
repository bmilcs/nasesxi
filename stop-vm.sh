#!/bin/sh
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ESXI STOP VMS [./stop-vm.sh]

mypath="$(dirname "$(realpath "$0")")" ; . "$mypath/config"
vmxname=$1

if [ $# -ne 1 ]; then
  _e "$0: error! Not enough arguments"
  _e "Usage is: $0 user_id esxi_host_name vmx_filename"
  _e "Only specify the vmx basefilename; leave off the '.vmx' extension"
  exit 1
fi

guestvmids=$(ssh "${esxiuser}"@"${esxihost}" vim-cmd vmsvc/getallvms \
  | grep "/${vmxname}.vmx" | awk '$1 ~ /^[0-9]+$/ {print $1}')

_e "$(date): $0 ${esxiuser}@${esxihost} vmx=${vmxname}.vmx"

for guestvmid in $guestvmids; do
  shutdown_guest_vm "$guestvmid"
done

