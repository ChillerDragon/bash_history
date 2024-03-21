#!/bin/bash

# load this from your ~/.bashrc
# for example
#
#   source ~/Desktop/git/bash_history/init.sh
#

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

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
  local match
  match="$( (tac "$hist_file"; cat "$SCRIPT_DIR/bash_history"; test -f "$SCRIPT_DIR"/nudes.txt && cat "$SCRIPT_DIR"/nudes.txt) | fzf)"
  [ "$match" != "" ] && READLINE_LINE="$match"
}

bind -x '"\C-r":"__chiller_hist_flipper"'

