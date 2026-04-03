#!/usr/bin/env sh

# List currently available incus remotes, name only
# Currently slightly problematic as the current default appends (current)
# So would need to trim that string off the end
list_remotes() {
	local exit_code
	incus remote ls -f compact,noheader -c n
	exit_code=$?

	return ${exit_code}
}

# Lists all instances for current default remote
# Returns name only, unsure if instance names can contain spaces
list_instances() {
	local exit_code
	incus list -f compact,noheader -c n
	exit_code=$?

	return ${exit_code}
}

# Export instance to stdout uncompressed
# Optimized storage format enabled by default, may enable support for unoptimized storage if I feel like it
# Takes one argument, the instance name
export_instance() {
	local instance exit_code
	instance="$1"

	incus export "${instance}" -  --compression none --optimized-storage
	exit_code=$?

	return ${exit_code}
}
