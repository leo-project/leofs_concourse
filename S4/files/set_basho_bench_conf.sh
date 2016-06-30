#!/bin/bash

LEOFS_GW_HOST=$1
LEOFS_GW_PORT=$2
TEMPLATE_PATH="leofs_concourse/S4/files/templates"
CONF_PATH="leofs_basho_bench_conf"

TARGETS=("image_f4m_load" "image_f4m_r95w5_5min")

for target in "${TARGETS[@]}"
do
	sed -e "s/{{ leofs_gw_hosts }}/\"$LEOFS_GW_HOST\"/g;s/{{ leofs_gw_port }}/$LEOFS_GW_PORT/g" ${TEMPLATE_PATH}/${target}.conf.j2 | tee $CONF_PATH/${target}.conf
done
