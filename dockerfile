# varialbes
ARG DOWNLOAD_USERNAME=user@dom.tld
ARG DOWNLOAD_PASSWORD=password
ARG DOWNLOAD_FOLDER=/opt/appd/machine_agent
ARG DOWNLOAD_VERSION=20.10.0.2813

#----------------------------
FROM openjdk:8u151-jre-alpine3.7 AS builder
# refresh variables
ARG DOWNLOAD_USERNAME
ARG DOWNLOAD_PASSWORD
ARG DOWNLOAD_FOLDER
ARG DOWNLOAD_VERSION
# needed packages
RUN apk --no-cache add curl
# download agent
ADD download_machine_agent.sh .
RUN mkdir -p $DOWNLOAD_FOLDER
RUN sh ./download_machine_agent.sh\ 
    ${DOWNLOAD_VERSION}\
    ${DOWNLOAD_USERNAME}\
    ${DOWNLOAD_PASSWORD}\
    ${DOWNLOAD_FOLDER}
CMD tail -f /dev/null

#-------------------------------------
FROM openjdk:8u151-jre-alpine3.7 AS java-machine-agent
# refresh variables
ARG DOWNLOAD_FOLDER
ARG DOWNLOAD_VERSION
# environment varialbes
ENV AGENT_DIR=${DOWNLOAD_FOLDER}
ENV AGENT_VERSION=${DOWNLOAD_VERSION}
# needed packages
RUN apk --no-cache add vim bash
# create folder and copy agent
RUN mkdir -p ${AGENT_DIR}
COPY --from=0 ${DOWNLOAD_FOLDER}/* ${AGENT_DIR}/
WORKDIR ${AGENT_DIR}
ADD start_machine_agent.sh .
#ENTRYPOINT /bin/bash ./start_machine_agent.sh
ENTRYPOINT tail -f /dev/null
