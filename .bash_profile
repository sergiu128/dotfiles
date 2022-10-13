source "$HOME/.cargo/env"

export PATH="$PATH:~/go/bin:/usr/local/bin:/opt/homebrew/bin"
export PS1='\[\e[1;32m\][sergiu@\h]\w\$\[\e[0m\] '

eval "$(starship init bash)"

alias vim='nvim'

alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias path='echo ${PATH//:/\\n}'
alias du='du -kh'
alias df='df -kh'

alias la='ls -Al'               # show hidden files
alias ls='ls -hF --color'	      # add colors for filetype recognition
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'		          # sort by change time  
alias lu='ls -lur'		          # sort by access time   
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date

alias python='python3'
alias pip='pip3'

alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs="git status"

alias make="make -j 20"

# eternal history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sergiu/google-cloud-sdk/path.bash.inc' ]; then . '/Users/sergiu/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sergiu/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/sergiu/google-cloud-sdk/completion.bash.inc'; fi

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
