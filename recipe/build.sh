#!/bin/bash

set -exuo pipefail

export CGO_ENABLED=0

echo "PKG_VERSION = ${PKG_VERSION}"

go build \
  -trimpath \
  -ldflags "-X main.version=${PKG_VERSION}" \
  -o "${BINARY_FILEPATH}"


# save thirdparty licenses
go-licenses save . --save_path ./thirdparty --ignore github.com/terraform-docs/terraform-docs

# Clear out cache to avoid file not removable warnings
chmod -R u+w $(go env GOPATH) && rm -r $(go env GOPATH)