#!/bin/bash

# Arguments
SCRIPT_DIR="$1"
CONFIG_DIR="$2"

# Variables
SOURCERY="${SCRIPT_DIR}"
CONFIG="${CONFIG_DIR}"

# Run Sourcery
"${SOURCERY}" --config "${CONFIG}" --verbose
