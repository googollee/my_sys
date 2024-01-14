#!/bin/sh

# Setup Fluxcd
brew install fluxcd/tap/flux
flux bootstrap github \
  --owner=googollee \
  --repository=my_sys \
  --branch=main \
  --path=./home-cluster/flux \
  --personal
