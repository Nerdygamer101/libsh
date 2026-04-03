#!/usr/bin/env sh

. $HOME/restic.conf
. lib-podman.sh

backup_all_volumes
