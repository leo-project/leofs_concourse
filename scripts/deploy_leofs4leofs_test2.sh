#!/bin/bash
set -e

cp leofs_concourse/ansible/deploy_leofs4leofs_test2.yml leofs_ansible/deploy_leofs.yml

echo $ANSIBLE_KEY > ansible_key
sed -i -e 's/ /\n/g; s/BEGIN\nRSA\nPRIVATE\nKEY/BEGIN RSA PRIVATE KEY/g; s/END\nRSA\nPRIVATE\nKEY/END RSA PRIVATE KEY/g' ansible_key
chmod 600 ansible_key

if [ "$ANSIBLE_SUDO" = true ]; then
    SUDO_SWITCH="-b"
else
    SUDO_SWITCH=""
fi

ansible-playbook -i $ANSIBLE_INVENTORY leofs_ansible/purge_leofs.yml $SUDO_SWITCH -u $USER --private-key=ansible_key 
ansible-playbook -i $ANSIBLE_INVENTORY leofs_ansible/deploy_leofs.yml $SUDO_SWITCH -u $USER --private-key=ansible_key 

./leofs-adm status
./leofs-adm add-endpoint $LEOFS_GW_HOST
