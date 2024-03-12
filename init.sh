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
  local match
  match="$( (grep -v '^#' ~/.bash_history; cat "$SCRIPT_DIR/bash_history") | fzf)"
  [ "$match" != "" ] && READLINE_LINE="$match"
}

bind -x '"\C-r":"__chiller_hist_flipper"'

