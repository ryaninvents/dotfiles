# Author: Ryan Muller Kennedy
# This plugin provides an fzf-based file palette for kakoune.
define-command -docstring "Open fzf file palette" \
fuzzp -params .. %{
	evaluate-commands %sh{
		tmp="/tmp/rmk-fzf-$(date +%s%N)"
		mkdir -p "${tmp}"
		fzf="${tmp}/fzf"
		result="${tmp}/result"
		(
			printf "%s\n" "cd \"${PWD}\" && fzf --height 100% > ${result} && rm \"${fzf}\""
		) >> "${fzf}"
		chmod 755 "${fzf}"

  	if [ -n "${kak_client_env_TMUX}" ]; then
  		tmux_command="popup -E -t '${kak_client_env_TMUX_PANE}' -h 50% -w 80%"
    	printf "%s\n" "nop %sh{ command tmux ${tmux_command} env ${fzf} < /dev/null > /dev/null 2>&1 }"

    	(
    		while [ -e "${fzf}" ]; do sleep 0.1; done
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

map global normal <c-p> ':fuzzp<ret>'
