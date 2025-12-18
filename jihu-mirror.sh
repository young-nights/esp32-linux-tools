#!/bin/bash
#
# Redirects github repos to jihu mirrors.
#
#

set -e
set -u

if [[ "$@" == "" ]]; then
    echo "Usage:"
    echo "    Set the mirror:   ./jihu-mirror.sh set"
    echo "    Unset the mirror: ./jihu-mirror.sh unset"
fi

if [[ "$@" == "set" ]]; then
    git config --global url.https://jihulab.com/esp-mirror.insteadOf https://github.com
elif [[ "$@" == "unset" ]]; then
    git config --global --unset url.https://jihulab.com/esp-mirror.insteadof
fi