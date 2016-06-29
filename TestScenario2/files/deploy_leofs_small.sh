#!/bin/bash
set -e

cd leofs_ansible

echo $1 > ansible_key
sed -i -e 's/ /\n/g; s/BEGIN\nRSA\nPRIVATE\nKEY/BEGIN RSA PRIVATE KEY/g; s/END\nRSA\nPRIVATE\nKEY/END RSA PRIVATE KEY/g' ansible_key
chmod 600 ansible_key

cp ../leofs_concourse/TestScenario2/files/deploy_leofs.yml .

ansible-playbook -i ../leofs_concourse/TestScenario2/files/hosts.small purge_leofs.yml -u wilson --private-key=ansible_key 
ansible-playbook -i ../leofs_concourse/TestScenario2/files/hosts.small build_leofs.yml -u wilson --private-key=ansible_key 
ansible-playbook -i ../leofs_concourse/TestScenario2/files/hosts.small deploy_leofs.yml -u wilson --private-key=ansible_key 

./leofs-adm status
./leofs-adm add-endpoint 192.168.100.35
sleep 5
./leofs-adm add-endpoint 192.168.100.35

./leofs-adm add-bucket test 05236
