
# don't set TERM to xterm if it's already using screen (probably in tmux)
if ! { [ "$TERM" = "screen" ] || [ "$TERM" = "screen-256color" ]; } then
	TERM='xterm-256color' # this causes problems when using SSH with cygwin
fi 

#source ~/terminal-config/solarized/mintty/sol.dark

# -2 starts tmux in 256 color mode, and for some reason TERM needs to be set to screen-256color or vim looks weird
alias tmux="TERM=screen-256color tmux -2"
# alias for searching design-expert repo excluding build folders and vim temp files
alias dgrep="grep --exclude-dir=cmake --exclude-dir=build* --exclude=*~ -RI --exclude=tags"

