#!/bin/bash

# Arguments
ROOT_DIR="$1"
PROJECT_DIR="$2"

# Variables
SOURCERY="${ROOT_DIR}/scripts/sourcery-2/bin/sourcery"
CONFIG="${PROJECT_DIR}/Tests/Sourcery/sourcery.yml"

# Run Sourcery
"${SOURCERY}" --config "${CONFIG}" --verbose