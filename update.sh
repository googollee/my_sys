#!/bin/sh

if command -v apt >/dev/null 2>&1; then
  sudo apt update
  sudo apt full-upgrade
fi

if command -v brew >/dev/null 2>&1; then
  brew update
  brew upgrade
  brew cleanup
fi

if command -v go >/dev/null 2>&1; then
  go install golang.org/x/tools/gopls@latest
  go install github.com/segmentio/golines@latest
  go install github.com/nametake/golangci-lint-langserver@latest
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
fi
