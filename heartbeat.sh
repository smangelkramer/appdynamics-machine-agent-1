#!/bin/bash
#
# AppDynamics example HTTP POST of metric to Machine Agent HTTP listener
# Maintainer: David Ryder
#
# Reference: https://docs.appdynamics.com/display/PRO45/Standalone+Machine+Agent+HTTP+Listener
#
PORT="$1"
POST_COUNT=1
POST_INTERVAL=60
VERBOSE=""
#VERBOSE="-v"

RESOURCE="/api/v1/metrics"
METRIC_DATA="[                                            \
					{\"metricName\":\"Custom Metrics|Heart Beat\",     \
					\"aggregatorType\":\"OBSERVATION\", \
					\"value\":\"1\"}
				]"

AGGREGATOR_TYPE="OBSERVATION"

while :; do
  sleep $POST_INTERVAL
	echo "Heart Beat"
  curl $VERBOSE -s --header "Content-Type: application/json" --data-binary "${METRIC_DATA}" -X POST "http://localhost:$PORT$RESOURCE"
done;