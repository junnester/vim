# VIM config repo
### Description

Installer script for vim plugins.   Please read.

Note: Rust language will be installed

### Script Compatability
* Ubuntu 18,19,20,22

```
# Start Script

# clone
git clone https://github.com/junnester/vim.git   ~/.vim

# linking
ln -s ~/.vim/vimrc ~/.vimrc

# clone
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install
vim +PluginInstall +qall

# note: ignore the Tommorow-Night-Eighties error... it will be installed.

###########
# WARNING #
###########

# fonts for Airline Status
sudo apt-get install fonts-powerline -y

# MarkDown Composer viewer plugin setup

# Install Rust language
cd /tmp
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs  > rust_installer.sh
sh ./rust_installer.sh -y

# compile the MarkDown viewer
cd ~/.vim/bundle/vim-markdown-composer
cargo build --release --no-default-features --features json-rpc

# End Script
```

CentOS 7
--------

### Install Powerline Fonts
run as root
``` bash
git clone https://github.com/powerline/fonts.git --depth=1

and install them
cd fonts ./install.sh

To make it available to every user copy it
mkdir /usr/share/fonts cp /root/.local/share/fonts/* /usr/share/fonts
```
