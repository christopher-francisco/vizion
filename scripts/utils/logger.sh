#!/bin/sh

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source "$SCRIPT_DIR/colors.sh"

log_step() {
  step=$1
  message=$2

  printf "$BLUE2 $BLACK$step $CLEAR $message"
}