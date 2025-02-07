#!/usr/bin/env bash
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com

#                 ESXI START DATASTORE VMS [./start-datastore-vms.sh]

#──────────────────────────────────────────────────────────  var/array  ───────

mypath="$(dirname "$(realpath "$0")")" ; . "$mypath/config"

logfile="${logdir}/start-datastore-vms.log"
waitdelay=30

VMs=(
  "Arch"
  "Backup"
  "Cloud"
  "DC1"
  "Debian"
  "Docker"
  "Guacamole"
  "kPi"
  "MPD"
  "mPi"
  "Plex"
  "Security"
  "UNMS"
  "Vault"
  "vCenter"
)


#──────────────────────────────────────────────────────────────  begin  ───────

_t start datastore vms

_a "- waitdelay: $waitdelay seconds before starting" \
  
sleep $waitdelay

for vm in "${VMs[@]}"; do
  echo "---[ starting: $vm" | tee "$logfile"
  "$mypath"/start-vm.sh "$vm" >> "$logfile"
done

#"$mypath"/start-vm.sh Docker >> "$logfile"
#"$mypath"/start-vm.sh Plex  >> "$logfile"
#"$mypath"/start-vm.sh mPi >> "$logfile"
#"$mypath"/start-vm.sh kPi >> "$logfile"
#"$mypath"/start-vm.sh MPD >> "$logfile"
#"$mypath"/start-vm.sh DC1  >> "$logfile"
#"$mypath"/start-vm.sh Guacamole  >> "$logfile"
#"$mypath"/start-vm.sh Security  >> "$logfile"
#"$mypath"/start-vm.sh UNMS  >> "$logfile"
#"$mypath"/start-vm.sh Backup  >> "$logfile"

