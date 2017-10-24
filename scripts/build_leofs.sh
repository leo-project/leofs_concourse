#!/bin/bash

mkdir -p leofs_bin/package
cd leofs_src;
rm -rf package; ln -s ../leofs_bin/package package
make && make release
