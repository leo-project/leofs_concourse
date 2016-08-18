#!/bin/bash
set -e

SSH_KEY=$ANSIBLE_KEY
INVENTORY=$ANSIBLE_INVENTORY
USER=$ANSIBLE_USER

cd leofs_ansible

echo $SSH_KEY > ansible_key
sed -i -e 's/ /\n/g; s/BEGIN\nRSA\nPRIVATE\nKEY/BEGIN RSA PRIVATE KEY/g; s/END\nRSA\nPRIVATE\nKEY/END RSA PRIVATE KEY/g' ansible_key
chmod 600 ansible_key

cp ../leofs_concourse/ansible/reconfig_gw.yml .

ansible-playbook -i ../$INVENTORY reconfig_gw.yml -u $USER --private-key=ansible_key

sleep 5
