#!/usr/bin/env bash

set -eux

dukkha_image="$1"

cache_dir="$(mktemp -d)"

docker pull "${dukkha_image}"
ctr_id="$(docker create "${dukkha_image}" : 2>/dev/null)"
docker cp "${ctr_id}:/dukkha" "${cache_dir}/dukkha"

chmod +x "${cache_dir}/dukkha"

echo "${cache_dir}" >>"${GITHUB_PATH}"
