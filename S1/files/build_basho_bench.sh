#!/bin/bash

cd leofs_basho_bench_src;
make;
cd ..
cp -r leofs_basho_bench_src/* leofs_basho_bench_bin
