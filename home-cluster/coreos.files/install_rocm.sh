#!/bin/sh

rpm-ostree install rocminfo rocm-opencl rocm-clinfo rocm-hip radeontop

echo HSA_OVERRIDE_GFX_VERSION=11.0.0
