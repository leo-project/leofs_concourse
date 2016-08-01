#!/bin/bash
set -x
set -e

SDK=$CLIENT_TEST_SDK
GW_HOST=$LEOFS_GW_HOST
GW_PORT=$LEOFS_GW_PORT

if [ "$AWS_SIGN_VER" = "v4" ]; then
    SIGN_VER="v4"
else
    SIGN_VER="v2"
fi

cd leofs_client_tests
(cd temp_data; ./gen.sh)

cd $SDK
## aws-sdk-go only v4
if [ $SDK == "aws-sdk-go" ]
then
    if [ $SIGN_VER == "v2" ]; then
        echo "Only Sign Ver v4"
    else
	    (echo "$GW_HOST testg$SIGN_VER.$GW_HOST" >> /etc/hosts)
        (export GOPATH=$HOME/go; go run LeoFSTest.go $SIGN_VER $GW_HOST $GW_PORT testg$SIGN_VER)
    fi

elif [ $SDK == "aws-sdk-java" ]
then
	(ant -Dsignver=$SIGN_VER -Dhost=$GW_HOST -Dport=$GW_PORT -Dbucket="testj$SIGN_VER")

elif [ $SDK == "aws-sdk-php" ]
then
	(echo "$GW_HOST testp$SIGN_VER.$GW_HOST" >> /etc/hosts)
	(curl -sS https://getcomposer.org/installer | php; php composer.phar install; php LeoFSTest.php $SIGN_VER $GW_HOST $GW_PORT testp$SIGN_VER)

elif [ $SDK == "aws-sdk-ruby" ]
then
	(echo "$GW_HOST testr$SIGN_VER.$GW_HOST" >> /etc/hosts)
	(ruby LeoFSTest.rb $SIGN_VER $GW_HOST $GW_PORT testr$SIGN_VER)

elif [ $SDK == "boto" ]
then
	(python LeoFSTest.py $SIGN_VER $GW_HOST $GW_PORT testb$SIGN_VER)

elif [ $SDK == "erlcloud" ]
then
    if [ $SIGN_VER == "v4" ]; then
        echo "Only Sign Ver v2"
    else
        (echo "$GW_HOST teste$SIGN_VER.$GW_HOST" >> /etc/hosts)
        (make deps; make compile; ./LeoFSTest.erl $SIGN_VER $GW_HOST $GW_PORT teste$SIGN_VER)
    fi

elif [ $SDK == "jclouds" ]
then
    if [ $SIGN_VER == "v4" ]; then
        echo "Only Sign Ver v2"
    else
        (mvn dependency:copy-dependencies; ant -Dsignver=$SIGN_VER -Dhost=$GW_HOST -Dport=$GW_PORT -Dbucket="testj$SIGN_VER")
    fi
fi
