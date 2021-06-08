#!/bin/sh
# Command-line parameters: user_id esxi_host_name vmx_base_filename
#
# Starts guest virtual machine with vmx file (vmx_base_filename'.vmx') on remote
# VMware ESXi server (esxi_host_name) using given user credentials (user_id)

# check for invocation errors

if [ $# -ne 3 ]; then
  echo "$0: error! Not enough arguments"
  echo "Usage is: $0 user_id esxi_host_name vmx_filename"
  echo "Only specify the vmx basefilename; leave off the '.vmx' extension"
  exit 1
fi

# gather command-line arguments for user id, hostname, and datastore name:

esxiuser=$1
esxihost=$2
vmxname=$3

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

