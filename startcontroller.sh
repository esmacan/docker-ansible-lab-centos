#!/bin/bash
##removing
    echo "removing container ansible.controller"
docker rm $(docker ps --filter "status=exited" --filter "status=dead" -q)

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NOF_HOSTS=3
NETWORK_NAME="ansible.lab"
WORKSPACE="${BASEDIR}/lab"

HOSTPORT_BASE=${HOSTPORT_BASE:-42726}
DOCKER_IMAGETAG=${DOCKER_IMAGETAG:-latest}
DOCKER_HOST_IMAGE="goffinet/centos-8-ansible-docker-host:${DOCKER_IMAGETAG}"
LAB_IMAGE="goffinet/ansible-controller:${DOCKER_IMAGETAG}"
    local entrypoint=""
    local args=""
    if [ -n "${TEST}" ]; then
        entrypoint="--entrypoint ansible"
        args="--version"
    fi
    echo "starting container ansible.controller"
    docker run --privileged -it -v "${WORKSPACE}":/root/lab:Z --net ${NETWORK_NAME} \
      --env HOSTPORT_BASE=$HOSTPORT_BASE \
      ${entrypoint} --name="ansible.controller" "${LAB_IMAGE}" ${args}
