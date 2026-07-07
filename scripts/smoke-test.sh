#!/bin/bash

set -e

URL=${1:-http://demo-app.local/health}

echo "Running smoke test..."

curl -f ${URL}

echo "Application is healthy"