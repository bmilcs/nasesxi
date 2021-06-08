#!/bin/sh

mypath="$( cd -- "$(dirname "")" >/dev/null 2>&1 ; pwd -P )"
"$mypath"/stop-all-vms.sh

