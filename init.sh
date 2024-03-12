#!/bin/bash

# load this from your ~/.bashrc
# for example
#
#   source ~/Desktop/git/bash_history/init.sh
#

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

__chiller_hist_flipper() {
  local match
  match="$( (grep -v '^#' ~/.bash_history; cat "$SCRIPT_DIR/bash_history") | fzf)"
  READLINE_LINE="$match"
}

bind -x '"\C-r":"__chiller_hist_flipper"'

