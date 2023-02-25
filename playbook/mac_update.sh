#!/bin/sh

brew update
brew upgrade
brew cleanup

. ./go_lsp_update.sh
