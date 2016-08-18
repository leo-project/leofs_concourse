#!/bin/bash

GW_HOST=$LEOFS_GW_HOST
NFS_TOKEN=$NFS_MOUNT_TOKEN

set -e

mkdir -p /mnt/leofs
mount -t nfs -o nolock $GW_HOST:/test/05236/$NFS_TOKEN /mnt/leofs

source leofs_concourse/scripts/run_basho_bench.sh
