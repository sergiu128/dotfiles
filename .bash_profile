export PS1='\[\e[1;32m\][sergiu@\h]\w\$\[\e[0m\] '
eval "$(starship init bash)"
export BASH_SILENCE_DEPRECATION_WARNING=1

source "$HOME/.cargo/env"
source "$HOME/.bashrc"

setup_ssh () {
  pgrep ssh-agent > /dev/null
  if [ `echo $?` == 1 ]; then
    eval `ssh-agent -s` > /dev/null
    ssh-add > /dev/null
  fi
}

setup_ssh
