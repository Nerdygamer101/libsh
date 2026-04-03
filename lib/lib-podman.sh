#!/usr/bin/env sh

# List podman volumes in a useful format
get_volumes() {
	podman volume ls -q || return 1
	return 0
}

# Checks if the volume given as an argument is anonymous
# Returns true if anonymous, false if not
check_anon_volume() {
	local volume="$1"
	podman volume inspect --format "{{.Anonymous}}" "$volume" || return 1
	return 0
}

# Lists all local volumes and exports them one at a time to stdout
backup_all_volumes() {
	. lib-backup.sh
	local volumes
	volumes=$(get_volumes)
	for volume in $volumes; do
		if [ "$(check_anon_volume "$volume")" = true ]; then
			echo "Skipping $volume"
			continue
		else
			echo "Backing up $volume"
			podman volume export "$volume" | backup_stdin "$volume"
		fi
	done
}
