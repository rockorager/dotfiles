#!/bin/sh

GOBIN=${GOBIN:-"$HOME/.local/bin"}
export GOBIN

mkdir -p "$GOBIN"

if ! command -v macctl >/dev/null 2>&1; then
    go install go.rockorager.dev/macctl/cmd/macctl@latest
fi
