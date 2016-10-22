#!/bin/sh

set -e
set -x

CLIENT_JAR=$1
shift

curl -L -o /opt/client.jar $CLIENT_JAR

$SPARK_HOME/bin/spark-submit $@
