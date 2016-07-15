#!/bin/bash
set -e

SSH_KEY=$ANSIBLE_KEY
INVETORY=$ANSIBLE_INVENTORY

cd leofs_ansible

echo $SSH_KEY > ansible_key
sed -i -e 's/ /\n/g; s/BEGIN\nRSA\nPRIVATE\nKEY/BEGIN RSA PRIVATE KEY/g; s/END\nRSA\nPRIVATE\nKEY/END RSA PRIVATE KEY/g' ansible_key
chmod 600 ansible_key

cp ../leofs_concourse/ansible/deploy_leofs.yml .

ansible-playbook -i ../leofs_concourse/ansible/hosts.large purge_leofs.yml -u wilson --private-key=ansible_key 
if [ "$DO_BUILD" = true ]; then
	ansible-playbook -i ../$ANSIBLE_INVENTORY build_leofs.yml -u wilson --private-key=ansible_key 
fi
ansible-playbook -i ../$ANSIBLE_INVENTORY deploy_leofs.yml -u wilson --private-key=ansible_key 

./leofs-adm status
./leofs-adm add-endpoint $LEOFS_GW_HOST
sleep 5
./leofs-adm add-endpoint $LEOFS_GW_HOST
./leofs-adm add-bucket test 05236

for bucket in "${BUCKETS[@]}"
do
	./leofs-adm add-bucket $bucket 05236
done
