#!/usr/bin/env bash
set -euo pipefail

ignore_file="${1:-ci/test-ignore-temporary.txt}"
lucee_test_dir="${2:-lucee/test}"

if [[ ! -f "$ignore_file" ]]; then
	echo "No temporary test ignore list at $ignore_file"
	exit 0
fi

while IFS= read -r line || [[ -n "$line" ]]; do
	line="${line%%#*}"
	line="$(echo "$line" | xargs)"
	[[ -z "$line" ]] && continue

	target="${lucee_test_dir%/}/${line}"
	if [[ -f "$target" ]]; then
		echo "Temporarily ignoring test: $target"
		rm -f "$target"
	else
		echo "Temporary ignore entry not found (skipped): $target"
	fi
done < "$ignore_file"
