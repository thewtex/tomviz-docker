#!/bin/sh

script_dir="`cd $(dirname $0); pwd`"

docker build -t tomviz/tomviz-build $script_dir
