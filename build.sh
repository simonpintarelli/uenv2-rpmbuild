#!/bin/bash

set -euo pipefail

export ref=v1.0.0
export remote=https://github.com/eth-cscs/uenv2
export slurm_version=23.11.7

_scriptdir=$(realpath "$(dirname "${BASH_SOURCE[0]}")")

set -exuo pipefail

IFS='.' read -r major minor patch <<<"$slurm_version"
wd=$(mktemp -d)

(
	cd $wd || exit 1
	echo "PWD $PWD"
	git clone -b $ref $remote src
	curl -L https://download.schedmd.com/slurm/slurm-${slurm_version}.tar.bz2 |
		tar -xj \
			slurm-${slurm_version}/slurm/spank.h \
			slurm-${slurm_version}/slurm/slurm_errno.h \
			slurm-${slurm_version}/slurm/slurm_version.h.in

	# The slurm version is hardcoded in the header in hexadecimal format, [major][minor][patch] (two digits each)
	SLURM_VERSION_NUMBER=$(printf '0x%02x%02x%02x' $major $minor $patch)
	echo "SLURM_VERSION_NUMBER: ${SLURM_VERSION_NUMBER}"

	# Create slurm_version.h from .in
	sed "s/^#undef SLURM_VERSION_NUMBER.*/#define SLURM_VERSION_NUMBER $SLURM_VERSION_NUMBER/" \
		slurm-${slurm_version}/slurm/slurm_version.h.in >slurm-${slurm_version}/slurm/slurm_version.h
	INCLUDE="-I$(realpath slurm-${slurm_version})"

	# Build RPM
	mkdir rpmbuild
	CXXFLAGS=$INCLUDE CFLAGS=$INCLUDE ./src/rpm/make-rpm.sh --slurm-version=$slurm_version ./rpmbuild 2>${_scriptdir}/stderr.log 1>${_scriptdir}/stdout.log

	find ./rpmbuild/RPMS -iname '*.rpm' -exec cp {} ${_scriptdir} \;
)
