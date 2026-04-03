#!/usr/bin/env sh

# ASSUMPTIONS
# Your environment is correctly set up to provide:
# RESTIC_REPOSITORY
# RESTIC_PASSWORD or RESTIC_PASSWORD_FILE or RESTIC_PASSWORD_COMMAND
# Any other environment variables specified here:
# https://restic.readthedocs.io/en/stable/075_scripting.html#environment-variables


# Takes one argument, the name to use for the stdin stream in the repository
backup_stdin() (
	set -eu
	local stdin_filename="$1"
	restic backup \
	--stdin=true \
	--stdin-filename="$stdin_filename" \
	--no-scan \
	-vv
)

# Takes one argument, a percentage or fraction of the repo to check
check_repo() {
	restic check \
	--read-data-subset="$1"
}

# Keeps ALL snapshots for the last 30 days by default
# Then 3 monthly snapshots afterwards
# The rationale for keeping all snapshots is explained here:
# https://restic.readthedocs.io/en/stable/060_forget.html#security-considerations-in-append-only-mode
prune_repo() {
	restic forget \
	--prune=true \
	--keep-within 30d \
	--keep-within-monthly 3m
}
