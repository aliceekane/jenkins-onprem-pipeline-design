#!/bin/bash

set -e

RELEASE_NAME="demo-app"

echo "Rolling back deployment..."

helm rollback ${RELEASE_NAME}

echo "Rollback completed"