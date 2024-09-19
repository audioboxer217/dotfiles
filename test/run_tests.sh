#!/usr/bin/env bash
set -eo pipefail

# Ensure submodules are in place and up-to-date
git submodule update --init


DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
mkdir "${DIR}"/output

"${DIR}"/bats/bin/bats --pretty --report-formatter tap --output "${DIR}"/output "${DIR}"/*.bats

echo "# BATS Summary" > "${GITHUB_STEP_SUMMARY-test.md}"
echo "|Name|Result|" >> "${GITHUB_STEP_SUMMARY-test.md}"
echo "|---|---|" >> "${GITHUB_STEP_SUMMARY-test.md}"
{
  read
  while read line; do
    read -r -a test_arr <<< "$line"
    if [[ "${test_arr[0]}" == 'ok' ]]
    then
      status="✅"
      name=("${test_arr[@]:2}")
    else
      status="❌"
      name=("${test_arr[@]:3}")
    fi

    echo "${name[@]}|${status}" >> "${GITHUB_STEP_SUMMARY-test.md}"
  done 
} <"${DIR}"/output/report.tap

rm -rf "${DIR}"/output