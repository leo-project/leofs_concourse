#!/bin/bash

LEOFS_GW_HOST=$1
LEOFS_GW_PORT=$2
TEMPLATE_PATH="leofs_concourse/S4/files/templates"
CONF_PATH="leofs_basho_bench_conf"

shopt -s nullglob
for template in ${TEMPLATE_PATH}/*.conf.j2
do
	target=${template##*/}
	target=${target%.*}
	sed -e "s/{{ leofs_gw_hosts }}/\"$LEOFS_GW_HOST\"/g;s/{{ leofs_gw_port }}/$LEOFS_GW_PORT/g" ${TEMPLATE_PATH}/${target}.j2 | tee $CONF_PATH/${target}
done
