export PS1='\[\e[1;32m\][sergiu@\h]\w\$\[\e[0m\] '

source "$HOME/.cargo/env"

export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="~/go/bin:/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/python/bin:$PATH"
export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="/opt/homebrew/opt/libpcap/bin:$PATH"

alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias path='echo ${PATH//:/\\n}'
alias du='du -kh'
alias df='df -kh'
alias vim='nvim'

alias la='ls -Al'               # show hidden files
alias ls='ls -hF --color'	# add colors for filetype recognition
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'		# sort by change time  
alias lu='ls -lur'		# sort by access time   
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date

alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs="git status"
alias gc="git commit"

alias make="make -j 20"

# eternal history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

setup_ssh () {
  pgrep ssh-agent > /dev/null
  if [ `echo $?` == 1 ]; then
    eval `ssh-agent -s` > /dev/null
    ssh-add
  fi
}

setup_ssh

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

source ~/.bash_work
