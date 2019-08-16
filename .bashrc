
# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

source "${HOME}/terminal-config/.linux.bashrc"

if [ -f "${HOME}/terminal-config/.general.bashrc" ]; then
	source "${HOME}/terminal-config/.general.bashrc"
fi

if [ -f "${HOME}/terminal-config/.solarized.bashrc" ]; then
	source "${HOME}/terminal-config/.solarized.bashrc"
fi

if [ -f "${HOME}/.local.bashrc" ]; then
	source "${HOME}/.local.bashrc"
fi

ssh-add
