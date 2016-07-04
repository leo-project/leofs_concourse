#!/bin/bash
set -x
set -e

SDK=$CLIENT_TEST_SDK
GW_HOST=$LEOFS_GW_HOST
GW_PORT=$LEOFS_GW_PORT

cd leofs_client_tests
(cd temp_data; ./gen.sh)

## aws-sdk-go only v4
#(export GOPATH=$HOME/go; cd aws-sdk-go; go run LeoFSTest.go v4 $GW_HOST $GW_PORT testg)

cd $SDK
if [ $SDK == "aws-sdk-java" ]
then
	(ant -Dsignver=v2 -Dhost=$GW_HOST -Dport=$GW_PORT -Dbucket="testj")

elif [ $SDK == "aws-sdk-php" ]
then
	(echo "$GW_HOST testp.$GW_HOST" >> /etc/hosts)
	(curl -sS https://getcomposer.org/installer | php; php composer.phar install; php LeoFSTest.php v2 $GW_HOST $GW_PORT testp)

elif [ $SDK == "aws-sdk-ruby" ]
then
	(echo "$GW_HOST testr.$GW_HOST" >> /etc/hosts)
	(ruby LeoFSTest.rb v2 $GW_HOST $GW_PORT testr)

elif [ $SDK == "boto" ]
then
	(python LeoFSTest.py v2 $GW_HOST $GW_PORT testb)

elif [ $SDK == "erlcloud" ]
then
	(echo "$GW_HOST teste.$GW_HOST" >> /etc/hosts)
	(make deps; make compile; ./LeoFSTest.erl v2 $GW_HOST $GW_PORT teste)

elif [ $SDK == "jclouds" ]
then
	(mvn dependency:copy-dependencies; ant -Dsignver=v2 -Dhost=$GW_HOST -Dport=$GW_PORT -Dbucket="testj")
fi
