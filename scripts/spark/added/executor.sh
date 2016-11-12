#!/bin/sh

set -e
set -x

cd $SPARK_HOME

if [[ "$1" == "dynamic-executors" ]]
then
    shift
    $SPARK_HOME/sbin/start-shuffle-service.sh
fi

$SPARK_HOME/bin/spark-class $@
