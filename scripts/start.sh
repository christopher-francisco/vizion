#!/usr/bin/env bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source "$SCRIPT_DIR/utils/colors.sh"
source "$SCRIPT_DIR/utils/logger.sh"

printf "Vizion ${BOLD}1.0.0${CLEAR} started"