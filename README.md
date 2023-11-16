# WSL Setup, if applicable

 If using WSL2,

- Install a [Nerd Font](https://github.com/ryanoasis/nerd-fonts) (Ubuntu Mono preferred) in window terminal and set it as the default font
- Set windows terminal theme to [catppuccin macchiato](https://github.com/catppuccin/windows-terminal)


Just to get ready, we will go ahead these packages

    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install fish git neofetch powerline terminfo wget zsh 

if using a CUDA enabled GPU, configure cuda 

    sudo apt-key del 7fa2af80
    wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb
    sudo dpkg -i cuda-keyring_1.1-1_all.deb
    sudo apt-get update
    sudo apt-get install libxcursor-dev libxinerama1 cuda gettext

check that cuda installed properly by running `which nvidia-smi`

if we run into `ldconfig: /usr/lib/wsl/lib/libcuda.so.1 is not a symbolic link`, handle that by using the following snippet from [this](https://github.com/microsoft/WSL/issues/8587#issuecomment-1335233596) related issue. 
    
    cd /usr/lib/wsl/lib
    # backup
    sudo mv libcuda.so.1 libcuda.so.1.backup
    sudo mv libcuda.so libcuda.so.backup
    # create symlink manually
    sudo ln -s libcuda.so.1.1 libcuda.so.1
    sudo ln -s libcuda.so.1 libcuda.so
    # update cache
    sudo ldconfig
    cd ~

-----

# Load dotfiles

Either clone the repo with

    git clone https://github.com/Taylor-Alex-Raine/dotfiles.git .

or by downloading your relevant files to their home locations.

## Configure `xterm-256color-italic` terminal

Ensure that terminfo is installed with `which terminfo`, then run

    tic xterm-256color-italic.terminfo

to compile the xterminal.

## Install [`TMUX`](https://github.com/tmux/tmux) and [`TPM`](https://github.com/tmux-plugins/tpm)

Run the commands below to install tmux and tpm

    sudo apt-git install tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

then if tmux is already running, run `tmux source ~/.tmux.conf` to reload the config. 

Run TPM's install script with `prefix` + <kbd>I</kbd> (here I have the prefix as the default <kbd>CTRL</kbd> + <kbd>B</kbd>).

## Configure [`fish`](https://fishshell.com/)

Fish checks its config on launch, so no source command is needed. We can set it as the default shell with the below. 

    sudo echo /usr/bin/fish | sudo tee -a /etc/shells
    sudo chsh -s /usr/bin/fish

_note that current my config.fish auto opens tmux if it is not already running_

# `Vim` Install

We will mostly follow [Zoey Greer's vim install script](https://github.com/tempoz/dotfiles) - though we will use `catppuccin/vim` instead of using powerline
  
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install python3-dev clang make man curl git-lfs 7zip libgtk-3-dev vim-gtk3 liblua5.4-dev lua5.4 tig 

compile with
    
    ./configure --enable-multibyte --enable-rubyinterp --enable-python3interp --with-python3-config-dir=(python3-config --configdir) --enable-perlinterp --enable-luainterp --disable-pythoninterp --disable-mzschemeinterp --enable-tclinterp --with-tclsh=/usr/bin/tclsh --with-features=huge --prefix=/usr/ --enable-cscope --disable-gui --enable-autoservername='yes' --enable-gui=gtk3

## [vim-plug](https://github.com/junegunn/vim-plug) install

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

enable with `:PlugInstall` in vim
