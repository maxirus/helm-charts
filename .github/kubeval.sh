#!/bin/bash
# set -euo pipefail
set -e

# https://github.com/instrumenta/kubeval

echo "[INFO] Setting up environment..."
BRANCH=$(git rev-parse --abbrev-ref HEAD)
CHART_DIRS="$(git diff --find-renames --name-only "${BRANCH}" remotes/origin/master -- charts | grep '[cC]hart.yaml' | sed -e 's#/[Cc]hart.yaml##g')"
if [[ "${CHART_DIRS}" == "" ]]; then
    echo "[INFO] No chart updates detected"
    exit 0
fi
# Docs: https://github.com/instrumenta/kubeval/
KUBEVAL_VERSION="0.16.1"
SCHEMA_LOCATION="https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/"

# install kubeval
echo "[INFO] Install kubeval..."
curl --silent --show-error --fail --location --output /tmp/kubeval.tar.gz https://github.com/instrumenta/kubeval/releases/download/"${KUBEVAL_VERSION}"/kubeval-linux-amd64.tar.gz
tar -xf /tmp/kubeval.tar.gz kubeval
echo "[INFO] kubeval installed"

echo "[INFO] Validating charts.."
# validate charts
for CHART_DIR in ${CHART_DIRS}; do
  helm template "${CHART_DIR}" | ./kubeval --strict --ignore-missing-schemas --kubernetes-version "${KUBERNETES_VERSION#v}" --schema-location "${SCHEMA_LOCATION}"
done