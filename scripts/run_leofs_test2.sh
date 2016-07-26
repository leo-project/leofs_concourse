#!/bin/bash
set -e
USER=$ANSIBLE_USER
source /usr/local/erlang/activate
cd leofs_test2
make

echo $ANSIBLE_KEY > ansible_key
sed -i -e 's/ /\n/g; s/BEGIN\nRSA\nPRIVATE\nKEY/BEGIN RSA PRIVATE KEY/g; s/END\nRSA\nPRIVATE\nKEY/END RSA PRIVATE KEY/g' ansible_key
chmod 600 ansible_key

./leofs_test -m $LEOFS_MANAGER_NODE -b test -g $LEOFS_GW_HOST -p $LEOFS_GW_PORT -u $USER -a ansible_key -s $SCENARIO
