#!/usr/bin/env bash
set -eo pipefail

# Run this file to run all the tests, once
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" >/dev/null 2>&1 && pwd  )"
"${DIR}"/libs/bats/bin/bats "${DIR}"/*.bats