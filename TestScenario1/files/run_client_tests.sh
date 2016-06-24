#!/bin/bash
set -x
set -e

host=$1
port=$2

cd leofs_client_tests
(cd temp_data; ./gen.sh)
## aws-sdk-go only v4
#(export GOPATH=$HOME/go; cd aws-sdk-go; go run LeoFSTest.go v4 $host $port testg)

(cd aws-sdk-java; ant -Dsignver=v2 -Dhost=$host -Dport=$port -Dbucket="testj")

(echo "$host testp.$host" >> /etc/hosts)
(cd aws-sdk-php; curl -sS https://getcomposer.org/installer | php; php composer.phar install; php LeoFSTest.php v2 $host $port testp)

(echo "$host testr.$host" >> /etc/hosts)
(cd aws-sdk-ruby; ruby LeoFSTest.rb v2 $host $port testr)

(cd boto; python LeoFSTest.py v2 $host $port testb)

(echo "$host teste.$host" >> /etc/hosts)
(cd erlcloud; make deps; make compile; ./LeoFSTest.erl v2 $host $port teste)

(cd jclouds; mvn dependency:copy-dependencies; ant -Dsignver=v2 -Dhost=$host -Dport=$port -Dbucket="testj")
