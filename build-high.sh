#!/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DEV_HOSTS=${DEV_HOSTS:-localhost}
PLAYBOOK=${PLAYBOOK:-$(readlink -f "${DIR}/books/build.yml")}

export ANSIBLE_INVENTORY="${ANSIBLE_INVENTORY:-$(readlink -f "${DIR}/ventory")}"

ansible-playbook \
-e "qual='high'" \
-e "extra='$@'" \
-l "${DEV_HOSTS}" \
"${PLAYBOOK}"
