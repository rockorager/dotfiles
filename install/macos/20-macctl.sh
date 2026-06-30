#!/bin/sh

if ! command -v macctl >/dev/null 2>&1; then
    go install go.rockorager.dev/macctl/cmd/macctl@latest
fi
