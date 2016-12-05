export SVN_EDITOR=vim
export EDITOR=vim

# human readable
alias du='du -h'
alias df='df -h'

# colors
alias ls='ls -hF --color=tty'
# grep with color, i = case insensitive, n = show line number, I = text only, E = posix regex, r = recursive
alias gr='grep -inIEr --color=always'
# add in the surrounding 2 lines
alias grc='grep -inIEr -C2 --color=always'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# case insensitive glob (does this work in linux or just cygwin?)
shopt -s nocaseglob

# function for viewing svn diffs in vim
svndiff()
{
	svn diff "${@}" | view -
}

# disable C-s turning off flow control (annoying if you press C-s to save files out of habit)
stty ixany
stty ixoff -ixon

# add colors to prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
