#!/bin/bash

set -euo pipefail

export ref=slurm
export remote=https://github.com/bcumming/uenv2
export slurm_version=23.11.7

# use bwrap to hide /usr/include/slurm
bwrap --dev-bind / / --tmpfs /usr/include/slurm bash ./build-impl.sh
