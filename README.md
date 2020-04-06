# VIM config repo
### Description

Installer script for vim plugins.   Please read.

Note: Rust language will be installed


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

# MarkDown Composer viewer plugin setup

# Install Rust language
cd /tmp
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs  > rust_installer.sh
sh ./rust_installer.sh -y

# compile the MarkDown viewer
cd ~/.vim/undle/vim-markdown-composer
cargo build --release --no-default-features --features json-rpc

# End Script
```
