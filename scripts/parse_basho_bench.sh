#!/bin/bash

set -e
set -x

TEST_NAME=$BASHO_BENCH_TEST_NAME
ERROR_THRES=$BASHO_BENCH_ERROR_THRES
GRAFANA_BASE="http://192.168.100.31:3000"
LEOFS_MANAGER_HOST="192.168.100.35"
LEOFS_MANAGER_PORT=10010

cd leofs_basho_bench_result/result_$TEST_NAME

ERROR=$(tail -n +2 summary.csv | awk '{total+=$3; err+=$5}END{print err/total}')
FAILED=$(awk -v err=$ERROR -v thres=$ERROR_THRES 'BEGIN{if (err >= thres) {print 1} else {print 0}}')

echo "Error Rate: $ERROR"

if [ $FAILED -eq 1 ]; then
	echo "Exceeded Threshold $ERROR_THRES"
	exit 1
fi

echo "status" | nc $LEOFS_MANAGER_HOST $LEOFS_MANAGER_PORT > status_file

MONITOR_PERIOD=$(cat monitor_period)

TZ=Asia/Tokyo /phantomjs-2.1.1-linux-x86_64/bin/phantomjs /phantomjs-2.1.1-linux-x86_64/bin/capture_5s.js $GRAFANA_BASE/dashboard/db/leofs-dashboard-ci$MONITOR_PERIOD grafana.png "1920px"

cd ../../
git clone leofs_notes leofs_notes_update
cd leofs_notes_update

TIME=$(TZ=Asia/Tokyo date +"%Y%m%d_%H%M")
mkdir ${TIME}_$TEST_NAME
(cd ${TIME}_$TEST_NAME && cp -r ../../leofs_basho_bench_result/result_$TEST_NAME/* .)

git config --global user.email "nobody@concourse.ci"
git config --global user.name "Concourse"

git add .
git commit -m "Added Test Case $TEST_NAME [$TIME]"
