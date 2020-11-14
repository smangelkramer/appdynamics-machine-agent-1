#!/bin/bash

VERSION=$1
USER=$2
PASSWORD=$3
FOLDER=$4
URL_LOGIN="https://identity.msrv.saas.appdynamics.com/v2.0/oauth/token"
URL_AGENT="https://download.appdynamics.com/download/prox/download-file/machine/${VERSION}/MachineAgent-${VERSION}.zip"
ZIP_AGENT="MachineAgent-${VERSION}.zip"

# login
echo ""
echo "----- Login -----"
echo URL_LOGIN: ${URL_LOGIN}
echo ""
RESPONSE=`curl -X POST -d '{"username": "'"${USER}"'","password": "'"${PASSWORD}"'","scopes": ["download"]}' ${URL_LOGIN}` 
TOKEN=`echo ${RESPONSE}  | sed s/\"/\\|/g | awk 'BEGIN{FS="|"}{print $10}'`
echo ""

# download agent
echo ""
echo "----- Download agent -----"
echo TOKEN: ${TOKEN}
echo VERSION: ${VERSION}
echo URL_AGENT: ${URL_AGENT}
echo ""
curl -L -O -H "Authorization: Bearer $TOKEN" $URL_AGENT
echo ""

# unzip agent
echo ""
echo "----- Unzip agent -----"
echo ZIP_AGENT: ${ZIP_AGENT}
echo FOLDER: ${FOLDER}
echo ""
mv ${ZIP_AGENT} ${FOLDER}
unzip ${FOLDER}/${ZIP_AGENT} -d ${FOLDER}
rm ${FOLDER}/${ZIP_AGENT}
echo ""

# debug section

#echo USER: ${USER}
#echo PASSWORD: ${PASSWORD}
#echo BODY: ${BODY}
#echo TOKEN: ${TOKEN}
