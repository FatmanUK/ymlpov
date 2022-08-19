#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEV_HOSTS=${DEV_HOSTS:-localhost}
PLAYBOOK=${PLAYBOOK:-$(readlink -f "${DIR}/books/build.yml")}

export ANSIBLE_INVENTORY="${ANSIBLE_INVENTORY:-$(readlink -f "${DIR}/ventory")}"

ANSIBLE_ARGS=''
POVRAY_ARGS=''

while (( "$#" )); do
        if [[ "-e" == "${1:0:2}" ]]; then
                ANSIBLE_ARGS="${ANSIBLE_ARGS} $1"
        else
                POVRAY_ARGS="${POVRAY_ARGS} $1"
        fi
        shift
done

ansible-playbook \
-e "qual='high'" \
-e "extra='${POVRAY_ARGS}'" \
${ANSIBLE_ARGS} \
-l "${DEV_HOSTS}" \
"${PLAYBOOK}"
