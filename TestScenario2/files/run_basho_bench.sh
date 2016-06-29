#!/bin/bash

TEST_NAME=$1
LOADER_CONF=$2
TEST_CONF=$3

set -e

cd leofs_basho_bench_bin
./basho_bench ../leofs_basho_bench_conf/$LOADER_CONF > ${TEST_NAME}.load.log
tail ${TEST_NAME}.load.log
echo "Cooldown, Sleep 60 seconds"
sleep 60
./basho_bench ../leofs_basho_bench_conf/$TEST_CONF > ${TEST_NAME}.log
tail ${TEST_NAME}.log
make results
