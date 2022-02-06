source "$HOME/.cargo/env"

alias vim='nvim'

alias rm='rm -i'
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

alias python='/usr/local/bin/python3'
alias pip='/usr/local/bin/pip3'

alias gl='git log --pretty=format:"%C(yellow)%h%C(red)%x09%an%C(blue)%x09%ad%C(reset)%x09%s" --date=relative'
alias gs='git status'

bind -x '"\C-f":"lf"'

export MYVIMRC=/Users/sergiu/.config/nvim/init.vim
export LOCALHOST=1

# eternal history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
