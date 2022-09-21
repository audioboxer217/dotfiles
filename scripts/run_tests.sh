#!/usr/bin/env bash
set -eo pipefail

# Run this file to run all the tests, once
REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )/.." >/dev/null 2>&1 && pwd  )"
${REPO_DIR}/test/libs/bats/bin/bats ${REPO_DIR}/test/*.bats
