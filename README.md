# Basics 

### If using WSL2,

- Install a [Nerd Font](https://github.com/ryanoasis/nerd-fonts) (Ubuntu Mono preferred) in window terminal and set it as the default font
- Set windows terminal theme to [catppuccin macchiato](https://github.com/catppuccin/windows-terminal)


Just to get ready, we will go ahead these packages

    sudo apt-get install fish neofetch powerline terminfo zsh
    tic xterm-256color-italic.terminfo


# `Vim` Install

We will mostly follow [Zoey Greer's vim install script](https://github.com/tempoz/dotfiles). 
  
    sudo apt-get update
    sudo apt-get install python3-dev clang make man curl powerline git-lfs 7zip libgtk-3-dev vim-gtk3 liblua5.4-dev lua5.4 tig 

if WSL[2] with a CUDA enabled GPU, configure cuda 

    sudo apt-key del 7fa2af80
    wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb
    sudo dpkg -i cuda-keyring_1.1-1_all.deb
    sudo apt-get install libxcursor-dev libxinerama1 cuda gettext

compile with
    
    ./configure --enable-multibyte --enable-rubyinterp --enable-python3interp --with-python3-config-dir=(python3-config --configdir) --enable-perlinterp --enable-luainterp --disable-pythoninterp --disable-mzschemeinterp --enable-tclinterp --with-tclsh=/usr/bin/tclsh --with-features=huge --prefix=/usr/ --enable-cscope --disable-gui --enable-autoservername='yes' --enable-gui=gtk3

## [vim-plug](https://github.com/junegunn/vim-plug) install

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

enable with `:PlugInstall` in vim
