#!/bin/sh

mypath="$( cd -- "$(dirname "")" >/dev/null 2>&1 ; pwd -P )"

"$mypath"/rescan-datastores.sh
"$mypath"/start-datastore-vms.sh

