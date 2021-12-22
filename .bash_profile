export PS1='\[\e[1;32m\][sergiu@\h]\w\$\[\e[0m\] '
eval "$(starship init bash)"
export BASH_SILENCE_DEPRECATION_WARNING=1

source "$HOME/.cargo/env"
