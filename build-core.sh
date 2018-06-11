#!/bin/bash

TARGET=$1
if [ -z "$TARGET" ]; then
  echo Usage: $0 TARGET
  exit 1
fi

HOST_DIR=$(pwd)
GUEST_DIR=/build/
IMAGE=oe-builder
BUILD_DIR=build

if [ -n "$TEMPLATECONF" ]; then
  ENV="-e TEMPLATECONF=$GUEST_DIR/$(realpath --relative-to . $TEMPLATECONF)"
fi

docker run -v ${HOST_DIR}:${GUEST_DIR} -w ${GUEST_DIR} -u $(stat -c "%u:%g" .) ${ENV} ${IMAGE} bash -c "source openembedded-core/oe-init-build-env $BUILD_DIR ; bitbake ${TARGET}" 

