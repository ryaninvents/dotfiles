# Author: Ryan Muller Kennedy
# This plugin provides a ripgrep-based searcher for kakoune.

define-command -docstring "Open ripgrep searcher" \
rip -params .. %{
	evaluate-commands %sh{
		tmp="/tmp/rmk-rip-$(date +%s%N)"
		mkdir -p "${tmp}"
		rip="${tmp}/rip"
		result="${tmp}/result"
		(
			printf "%s\n" "set -euo pipefail"
			printf "%s\n" "cd \"${PWD}\""
			printf "%s\n" "export FZF_DEFAULT_COMMAND=\"rg --files --hidden --follow --glob '\\!.git'\""
			printf "%s\n" "fzf --height 100% > ${result} && rm \"${fzf}\""
		) >> "${rip}"
		chmod 755 "${rip}"

  	if [ -n "${kak_client_env_TMUX}" ]; then
  		tmux_command="popup -E -t '${kak_client_env_TMUX_PANE}' -h 50% -w 80%"
    	printf "%s\n" "nop %sh{ command tmux ${tmux_command} env ${rip} < /dev/null > /dev/null 2>&1 }"

    	(
    		while [ -e "${rip}" ]; do sleep 0.1; done
    		if [ -s "${result}" ]; then
      		(
      			while read -r line; do
							printf "%s\n" "evaluate-commands -client ${kak_client} edit ${line}"
      			done
      		) < "${result}" | kak -p "${kak_session:?}"
    		fi
    		rm -rf "${tmp}"
    	) > /dev/null 2>&1 < /dev/null &
  	fi
	}
}

map global user -docstring 'search workspace' f ':rip<ret>'
