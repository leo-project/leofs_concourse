#!/bin/bash
set -x
set -e

sdk=$1
host=$2
port=$3

cd leofs_client_tests
(cd temp_data; ./gen.sh)

## aws-sdk-go only v4
#(export GOPATH=$HOME/go; cd aws-sdk-go; go run LeoFSTest.go v4 $host $port testg)

cd $sdk
if [ $sdk == "aws-sdk-java" ]
then
	(ant -Dsignver=v2 -Dhost=$host -Dport=$port -Dbucket="testj")

elif [ $sdk == "aws-sdk-php" ]
then
	(echo "$host testp.$host" >> /etc/hosts)
	(curl -sS https://getcomposer.org/installer | php; php composer.phar install; php LeoFSTest.php v2 $host $port testp)

elif [ $sdk == "aws-sdk-ruby" ]
then
	(echo "$host testr.$host" >> /etc/hosts)
	(ruby LeoFSTest.rb v2 $host $port testr)

elif [ $sdk == "boto" ]
then
	(python LeoFSTest.py v2 $host $port testb)

elif [ $sdk == "erlcloud" ]
then
	(echo "$host teste.$host" >> /etc/hosts)
	(make deps; make compile; ./LeoFSTest.erl v2 $host $port teste)

elif [ $sdk == "jclouds" ]
then
	(mvn dependency:copy-dependencies; ant -Dsignver=v2 -Dhost=$host -Dport=$port -Dbucket="testj")
fi
