#!/bin/bash

set -e
set -x
GW_HOST=$LEOFS_GW_HOST
NFS_TOKEN=$NFS_MOUNT_TOKEN

mkdir -p /mnt/leofs/
MOUNT_HOST=$LEOFS_GW_HOST BUCKET=test/05236/$NFS_TOKEN leofs_src/apps/leo_gateway/test/leo_nfs_integration_tests.sh
