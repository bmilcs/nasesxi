#!/bin/sh

mypath="$( cd -- "$(dirname "")" >/dev/null 2>&1 ; pwd -P )"
. "$mypath"/host.config
. "$mypath"/esxi.config

if [ $# -ne 1 ]; then
  echo "$0: error! 1 arg only"
  echo "Usage is: $0 user_id esxi_host_name vmx_filename"
  echo "Only specify the vmx basefilename; leave off the '.vmx' extension"
  exit 1
fi

vmxname=$1

# get server id for the vm with matching vmx file:

guestvmids=$(ssh "${esxiuser}"@"${esxihost}" vim-cmd vmsvc/getallvms | grep "/${vmxname}.vmx" | awk '$1 ~ /^[0-9]+$/ {print $1}')

echo "$0: ${esxiuser}@${esxihost} vmx=${vmxname}.vmx"

for guestvmid in $guestvmids; do
  ssh "${esxiuser}"@"${esxihost}" vim-cmd vmsvc/power.getstate "${guestvmid}" | grep -i "Powered on" > /dev/null 2<&1
  l_status=$?

#  printf "VM [%s] status=[%s]\n" "${guestvmid}" "${l_status}"

  if [ $l_status -eq 0 ]; then
    echo "guest vm id $guestvmid already powered up..."
  else
    echo "powering up guest vm id $guestvmid..."
    ssh "${esxiuser}"@"${esxihost}" vim-cmd vmsvc/power.on "${guestvmid}" > /dev/null 2<&1
  fi
done

