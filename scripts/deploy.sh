#!/bin/bash

set -e

ENVIRONMENT=${1:-lab}

echo "Deploying application to ${ENVIRONMENT}"

helm upgrade --install demo-app \
../deploy/helm \
-f ../deploy/helm/values-${ENVIRONMENT}.yaml

echo "Deployment completed"