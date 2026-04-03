#!/usr/bin/env sh

# Use restic if the environment is set up
if [ -n "${RESTIC_REPOSITORY}" ]; then
	. lib-restic.sh
	return 0
fi

# If no supported backup tools are found, error out
echo "ERROR: No supported backup tools setup" 1>&2
echo "Currently supported tools: restic" 1>&2
exit 1
