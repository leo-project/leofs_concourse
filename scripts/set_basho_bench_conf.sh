#!/bin/bash

GW_HOST=$LEOFS_GW_HOST
GW_PORT=$LEOFS_GW_PORT
TEMPLATE_PATH="leofs_concourse/templates"
CONF_PATH="leofs_basho_bench_conf"

shopt -s nullglob
for template in ${TEMPLATE_PATH}/*.conf.j2
do
	target=${template##*/}
	target=${target%.*}
	sed -e "s/{{ leofs_gw_hosts }}/\"$GW_HOST\"/g;s/{{ leofs_gw_port }}/$GW_PORT/g" ${TEMPLATE_PATH}/${target}.j2 | tee $CONF_PATH/${target}
done
