#!bin/bash

# mapping of java properties to environment variables
# https://docs.appdynamics.com/display/PRO45/Machine+Agent+Configuration+Properties


LOG_CONFIG="-Dlog4j.configuration=file:/opt/appd/machine_agent/conf/logging/log4j.xml"

MA_PROPERTIES="" # ini machine agent properties

# mandatory properties
MA_PROPERTIES+="-Dappdynamics.controller.hostName=${APPDYNAMICS_CONTROLLER_HOST_NAME} "
MA_PROPERTIES+="-Dappdynamics.controller.port=${APPDYNAMICS_CONTROLLER_PORT} "
MA_PROPERTIES+="-Dappdynamics.agent.accountName=${APPDYNAMICS_AGENT_ACCOUNT_NAME%%_*} "
MA_PROPERTIES+="-Dappdynamics.agent.accountAccessKey=${APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY} "
MA_PROPERTIES+="-Dappdynamics.controller.ssl.enabled=${APPDYNAMICS_CONTROLLER_SSL_ENABLED} "
MA_PROPERTIES+="-Dappdynamics.agent.logs.dir=${APPDYNAMICS_AGENT_LOG_DIR} "

# optional properties
if [ "x${APPDYNAMICS_AGENT_UNIQUE_HOST_ID}" != "x" ]; then
    MA_PROPERTIES+="-Dappdynamics.agent.uniqueHostId=${APPDYNAMICS_AGENT_UNIQUE_HOST_ID} "
fi  

if [ "x${APPDYNAMICS_AGENT_CREATE_NODE_IF_ABSENT}" != "x" ]; then
    MA_PROPERTIES+="-Dappdynamics.machine.agent.registration.createNodeIfAbsent=${APPDYNAMICS_AGENT_CREATE_NODE_IF_ABSENT} "
fi    

if [ "x${APPDYNAMICS_HTTP_LISTENER}" != "x" ]; then
    MA_PROPERTIES+="-Dmetric.http.listener=${APPDYNAMICS_HTTP_LISTENER} "
fi    

if [ "x${APPDYNAMICS_HTTP_LISTENER_PORT}" != "x" ]; then
    MA_PROPERTIES+="-Dmetric.http.listener.port=${APPDYNAMICS_HTTP_LISTENER_PORT} "
fi    

if [ "x${APPDYNAMICS_AGENT_HIERARCHY_PATH}" != "x" ]; then # "Data Center 1|Rack 2|Machine3"
    MA_PROPERTIES+="-Dappdynamics.agent.hierarchyPath=${APPDYNAMICS_AGENT_HIERARCHY_PATH} "
fi    

if [ "x${APPDYNAMICS_AGENT_APPLICATION_NAME}" != "x" ]; then
    MA_PROPERTIES+="-Dappdynamics.agent.applicationName=${APPDYNAMICS_AGENT_APPLICATION_NAME} "
fi    

if [ "x${APPDYNAMICS_AGENT_NODE_NAME}" != "x" ]; then
    MA_PROPERTIES+="-Dappdynamics.agent.nodeName=${APPDYNAMICS_AGENT_NODE_NAME} "
fi

if [ "x${APPDYNAMICS_AGENT_TIER_NAME}" != "x" ]; then
    MA_PROPERTIES+="-Dappdynamics.agent.tierName=${APPDYNAMICS_AGENT_TIER_NAME} "
fi

if [ "x${APPDYNAMICS_HTTP_PROXY_HOST}" != "x" ]; then
    MA_PROPERTIES+="-Dappdynamics.http.proxyHost=${APPDYNAMICS_HTTP_PROXY_HOST} "
fi

if [ "x${APPDYNAMICS_HTTP_PROXY_PORT}" != "x" ]; then
    MA_PROPERTIES+="-Dappdynamics.http.proxyPort=${APPDYNAMICS_HTTP_PROXY_PORT} "
fi

if [ "x${APPDYNAMICS_HTTP_PROXY_USER}" != "x" ]; then
    MA_PROPERTIES+="-Dappdynamics.http.proxyUser=${APPDYNAMICS_HTTP_PROXY_USER} "
fi

if [ "x${APPDYNAMICS_HTTP_PROXY_PASSWORD_FILE}" != "x" ]; then
    MA_PROPERTIES+="-Dappdynamics.http.proxyPasswordFile=${APPDYNAMICS_HTTP_PROXY_PASSWORD_FILE} "
fi

if [ "x${APPDYNAMICS_AGENT_MAX_METRICS}" != "x" ]; then
    MA_PROPERTIES+="-Dappdynamics.agent.maxMetrics=${APPDYNAMICS_AGENT_MAX_METRICS} "
fi

# start Machine Agent
nohup java ${MA_PROPERTIES} $LOG_CONFIG -jar machineagent.jar