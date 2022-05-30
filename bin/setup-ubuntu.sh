#!/bin/bash
sudo snap install node --classic
sudo snap install nvim --classic
sudo snap install go --classic
# install vimplug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install go language server - will be used by neovim
go install golang.org/x/tools/gopls@latest

echo "\n# added by sergiu/setup.sh" >> ~/.bashrc
echo "export PATH=\$PATH:/snap/bin/:~/go/bin/" >> ~/.bashrc
echo "alias vim='nvim'" >> ~/.bashrc
echo "# added by sergiu/setup.sh\n" >> ~/.bashrc

source ~/.bashrc

