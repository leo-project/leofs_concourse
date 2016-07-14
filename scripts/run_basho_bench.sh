#!/bin/bash

LEAD_IN=30000
LEAD_OUT=60000

TEST_NAME=$BASHO_BENCH_TEST_NAME
LOADER_CONF=$BASHO_BENCH_LOAD_CONF
TEST_CONF=$BASHO_BENCH_TEST_CONF
BUCKET=$BASHO_BENCH_TEST_BUCKET

set -e

cd leofs_basho_bench_bin
./basho_bench ../leofs_basho_bench_conf/$LOADER_CONF > ${TEST_NAME}.load.log
tail ${TEST_NAME}.load.log
echo "Cooldown, Sleep 60 seconds"
sleep 60

echo "Start"
START_EPOCH=$(($(TZ=Asia/Tokyo date +%s%N)/1000000-$LEAD_IN))
./basho_bench ../leofs_basho_bench_conf/$TEST_CONF > ${TEST_NAME}.log
END_EPOCH=$(($(TZ=Asia/Tokyo date +%s%N)/1000000+$LEAD_OUT))
tail ${TEST_NAME}.log

echo "Cooldown, Sleep $(($LEAD_OUT/1000))"
sleep $(($LEAD_OUT/1000))

make results
cp -rL tests/current ../leofs_basho_bench_result/result_$TEST_NAME
echo "?from=${START_EPOCH}&to=${END_EPOCH}" > ../leofs_basho_bench_result/result_$TEST_NAME/monitor_period
cp *.log ../leofs_basho_bench_result/result_$TEST_NAME
