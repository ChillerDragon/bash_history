#!/bin/bash

# load this from your ~/.bashrc
# for example
#
#   source ~/Desktop/git/bash_history/init.sh
#

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

# i have ignoreboth set for my bash history
# but somehow shit does not work
# so i uniq it my self
# this might be causing issues and performance bottle necks
# so if anything starts to get bugged
# just nuke this function
#
# @param hist_file
__chiller_hist_flipper_deduplicate() {
	local hist_file="$1"
	if ! awk '!x[$0]++' "$hist_file" > "$hist_file".tmp
	then
		return 1
	fi
	if ! mv "$hist_file".tmp "$hist_file"
	then
		return 1
	fi
	return 0
}

__chiller_hist_flipper_dump_history() {
	local hist_file="$1"

	# vanilla history
	tac "$hist_file"

	# git tracked history
	cat "$SCRIPT_DIR/bash_history"

	# git ignored history
	test -f "$SCRIPT_DIR"/nudes.txt && cat "$SCRIPT_DIR"/nudes.txt

	# git submodule / sub folder git history
	local hist_dir
	for hist_dir in "$SCRIPT_DIR"/bash_history.d/*/
	do
		[ -d "$hist_dir" ] || continue

		local extra_file
		for extra_file in "$hist_dir"*.txt
		do
			[ -f "$extra_file" ] || continue

			cat "$extra_file"
		done
	done
}

__chiller_hist_flipper() {
	if [ ! -d "$SCRIPT_DIR" ]
	then
		echo "ChillerDragon does not know enough bash to write a simple script"
		return
	fi
	# write to history before searching
	# this way we can also search in commands
	# we just ran
	# which is a common use case duh
	history -a
	local hist_file="${HISTFILE:-~/.bash_history}"
	if [ ! -f "$hist_file" ]
	then
		echo "Error history file not found $hist_file"
		return
	fi

	if ! __chiller_hist_flipper_deduplicate "$hist_file"
	then
		echo "Error failed to deduplicate $hist_file"
		return
	fi

	local match
	match="$( ( \
		__chiller_hist_flipper_dump_history "$hist_file"; \
		) |
		fzf --prompt='[C-o] for old> ')"

	[ "$match" != "" ] && READLINE_LINE="$match"
}

if [ -s "$SCRIPT_DIR"/nudes.txt ]
then
	echo "Warning!! there are nudes in your history"
fi

bind -x '"\C-r":"__chiller_hist_flipper"'
bind '"\C-o":reverse-search-history'

