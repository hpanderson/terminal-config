git config --global core.excludesfile ~/.gitignore_global
git config --global color.ui true
git config --global user.name "Hank Anderson"
git config --global user.email "hank.p.anderson@gmail.com"

# automatically rebase always to avoid unnecessary merge commits
git config --global branch.autosetuprebase always

# handy aliases
git config --global alias.lg "log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)— %an%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative --date-order"
git config --global alias.lg2 "log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)— %an%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative"
git config --global alias.lg3 "log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(bold white)— %an%C(reset)' --abbrev-commit"
git config --global alias.stat "status"
git config --global alias.co "checkout"

git config --global core.autocrlf false

# this speeds up git on windows by a factor of 2 (still 50 times slower than linux)
git config --global core.preloadindex true

# only push current branch when no branch specified
git config --global push.default simple

