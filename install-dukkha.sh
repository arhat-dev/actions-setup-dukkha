#!/usr/bin/env bash

set -eux

version="$1"

cd "${GITHUB_ACTION_PATH}"

git clone --depth 1 --branch v1.8.0 \
  https://github.com/sigstore/cosign.git cosign-src

cd cosign-src
go build -mod=readonly -trimpath -ldflags="-s -w" -o ../sget ./cmd/sget
cd -

cache_dir="$(mktemp -d)"

./sget --key https://arhat.dev/.well-known/cosign.pub \
  -o "${cache_dir}/dukkha" \
  "ghcr.io/arhat-dev/dist/dukkha:${version}-$(go env GOHOSTOS)-$(go env GOHOSTARCH)"

chmod +x "${cache_dir}/dukkha"

echo "${cache_dir}" >>"${GITHUB_PATH}"
