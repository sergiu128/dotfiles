eval "$(starship init bash)"

export PATH="/home/sergiu/bin:$PATH"

export LOCALHOST=1
export PS1='\[\e[1;32m\][sergiu@\h]\w\$\[\e[0m\] '
export BASH_SILENCE_DEPRECATION_WARNING=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias vim='nvim'

alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias path='echo ${PATH//:/\\n}'
alias du='du -kh'
alias df='df -kh'

alias la='ls -Al'               # show hidden files
alias ls='ls -hF --color'	# add colors for filetype recognition
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'		# sort by change time  
alias lu='ls -lur'		# sort by access time   
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date

alias python='python3'
alias pip='pip3'

alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs="git status"

alias make="make -j 20"

bind -x '"\C-f":"lf"'

# eternal history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# git init --base $HOME/.cfg
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
config config --local status.showUntrackedFiles no

# on a new machine
# git clone --bare <repo> $HOME/.cfg
# config checkout
