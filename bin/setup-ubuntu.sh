#!/bin/bash

# this installs stuff needed to run and debug Go code easily on Ubuntu
# after this script runs, type vim and then :PlugUpdate
# then go mod tidy your go repo
# open any file in the repo
# g-d will take you to the function definition
# shift-k will give you the docs of the function
# go to the left tab with shift-o
# go to the right tab with shift-p

cd ~/

git clone https://github.com/sergiu128/dotfiles.git
mkdir -p .config
mkdir -p .config/nvim
cp dotfiles/.config/nvim/init.vim .config/nvim/init.vim
cd .config/nvim/
ln -s ~/.vim/autoload .

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

