#!/bin/bash

set -e
set -x

TEST_NAME=$BASHO_BENCH_TEST_NAME
ERROR_THRES=$BASHO_BENCH_ERROR_THRES
SLACK_WEBHOOK_URL=$SLACK_URL
GRAFANA_BASE="http://192.168.100.31:3000"
LEOFS_MANAGER_HOST="192.168.100.35"
LEOFS_MANAGER_PORT=10010
REPO_BASE_URL="https://github.com/windkit/test"

BASE_DIR=$(pwd)
cd $BASE_DIR/leofs_basho_bench_result/result_$TEST_NAME

ERROR=$(tail -n +2 summary.csv | awk '{total+=$3; err+=$5}END{print err/total}')
FAILED=$(awk -v err=$ERROR -v thres=$ERROR_THRES 'BEGIN{if (err >= thres) {print 1} else {print 0}}')

echo "Error Rate: $ERROR"

if [ $FAILED -eq 1 ]; then
	echo "Exceeded Threshold $ERROR_THRES"
	exit 1
fi

if [ "$CHECK_ONLY" = true ]; then
    exit 0
fi

echo "status" | nc $LEOFS_MANAGER_HOST $LEOFS_MANAGER_PORT > status_file
LEOFS_VERSION=$(grep "system version" status_file | cut -f 2 -d\| | xargs echo -n | tr -d '\r')

MONITOR_PERIOD=$(cat monitor_period)

TZ=Asia/Tokyo /phantomjs-2.1.1-linux-x86_64/bin/phantomjs /phantomjs-2.1.1-linux-x86_64/bin/capture_5s.js $GRAFANA_BASE/dashboard/db/leofs-dashboard-ci$MONITOR_PERIOD grafana.png "1920px"

cd $BASE_DIR
git clone leofs_notes leofs_notes_update
cd leofs_notes_update

TIME=$(TZ=Asia/Tokyo date +"%Y%m%d_%H%M")
DATE=$(TZ=Asia/Tokyo date +"%Y%m%d")
STIME=$(TZ=Asia/Tokyo date +"%H%M")
TARGET_DIR=benchmark/$LEOFS_VERSION/$DATE/
mkdir -p $BASE_DIR/leofs_notes_update/$TARGET_DIR
cd $BASE_DIR/leofs_notes_update/$TARGET_DIR
mkdir ${TEST_NAME}_$STIME
cd ${TEST_NAME}_$STIME
cp -r $BASE_DIR/leofs_basho_bench_result/result_$TEST_NAME/* .
cp $BASE_DIR/leofs_concourse/templates/README.md.j2 README.md 
sed -e "s/{{ leofs_version }}/$LEOFS_VERSION/" -i README.md
sed -e '/{{ leofs_status }}/ {' -e 'r status_file' -e 'd' -e '}' -i README.md
sed -e "s/\r//" -i README.md

git config --global user.email "nobody@concourse.ci"
git config --global user.name "Concourse"

cd $BASE_DIR/leofs_notes_update
git add .
git commit -m "Added Test Case $TEST_NAME [$TIME]"

curl -X POST -H "Content-type: application/json" --data "{\"text\":\"Benchmark [$TEST_NAME] Completed, Check at <$REPO_BASE_URL/tree/master/$TARGET_DIR/${TEST_NAME}_$STIME>\"}" $SLACK_URL
