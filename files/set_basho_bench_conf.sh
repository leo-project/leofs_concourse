#!/bin/bash

LEOFS_GW_HOST=$1
LEOFS_GW_PORT=$2

sed -e "s/{{ leofs_gw_hosts }}/\"$LEOFS_GW_HOST\"/g;s/{{ leofs_gw_port }}/$LEOFS_GW_PORT/g" leofs_concourse/files/templates/leofs_1m_f10k_load.conf.j2 | tee leofs_basho_bench_conf/test.conf
