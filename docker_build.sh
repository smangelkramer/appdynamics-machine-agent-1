#!/bin/bash

docker build \
				-t sm1705/appdynamics-machine-agent-http-listener:latest \
				--build-arg HTTP_PROXY \
				--build-arg DOWNLOAD_USERNAME=$APPD_DOWNLOAD_USERNAME \
				--build-arg DOWNLOAD_PASSWORD=$APPD_DOWNLOAD_PASSWORD \
				--no-cache \
				.
