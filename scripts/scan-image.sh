#!/bin/bash

set -e

IMAGE_NAME="demo-app:${BUILD_NUMBER:-local}"

echo "Scanning image..."

trivy image ${IMAGE_NAME}

echo "Security scan completed"