#!/bin/bash

set -e

IMAGE_NAME="demo-app"
IMAGE_TAG=${BUILD_NUMBER:-local}

echo "Building Docker image..."

docker build \
-t ${IMAGE_NAME}:${IMAGE_TAG} \
.

echo "Build completed successfully"