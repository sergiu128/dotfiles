export PATH="$PATH:~/go/bin:/usr/local/bin:/opt/homebrew/bin"
export PATH="/usr/local/opt/llvm/bin:/$HOME/go:$PATH"

export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@3/lib/pkgconfig"

export PS1='\[\e[1;32m\][sergiu@\h]\w\$\[\e[0m\] '
eval "$(starship init bash)"
export BASH_SILENCE_DEPRECATION_WARNING=1

source "$HOME/.cargo/env"
source "$HOME/.bashrc"
source "$HOME/.private"

echo '' >> /Users/sergiu/.bash_profile

setup_ssh () {
  pgrep ssh-agent > /dev/null
  if [ `echo $?` == 1 ]; then
    eval `ssh-agent -s` > /dev/null
    ssh-add
  fi
}

### LOAD AVA ENVIRONMENT VARS
if [ -f /Users/sergiu/code/talos/env/ava-vars.sh ]; then
  source /Users/sergiu/code/talos/env/ava-vars.sh
fi
### END LOAD AVA ENVIRONMENT VARS

setup_ssh






# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sergiu/google-cloud-sdk/path.bash.inc' ]; then . '/Users/sergiu/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sergiu/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/sergiu/google-cloud-sdk/completion.bash.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion






























































