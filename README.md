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

either way, if on Debian or Ubuntu, make sure to run

    sudo apt-get install cuda-toolkit

if on ubuntu run 

    sudo apt-get install nvidia-gds

then restart the wsl environment

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

    sudo apt-get install tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

then if tmux is already running, run `tmux source ~/.tmux.conf` to reload the config. 

Run TPM's install script with `prefix` + <kbd>I</kbd> (here I have the prefix as the default <kbd>CTRL</kbd> + <kbd>B</kbd>).

## Configure [`fish`](https://fishshell.com/)

Fish checks its config on launch, so no source command is needed. We can set it as the default shell with the below. 

    sudo echo $(which fish) | sudo tee -a /etc/shells
    sudo chsh -s $(which fish)

it may be necessary to log out and back in at this point, depending on your system

_note that current my config.fish auto opens tmux if it is not already running_

## Configure [`powerline`](https://powerline.readthedocs.io/en/master/)

Run the following to configure powerline to use the config from `~/.config/powerline/config.json`

    powerline-config tmux setup
    powerline-daemon --replace


# `VIM`

### Option 1: `nvim` install without `powerline`

this will with `catppuccin/vim` instead of using powerline for nvim
 
    sudo apt-get install curl neovim nodejs 
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

then open `nvim` and run `:PlugInstall`. `nvim` is very likely to produce errors before the install command is issued.

-----

### Option 2: `vim` with `powerline`

     sudo apt-get install curl neovim nodejs npm 

We will mostly follow [Zoey Greer's vim install script](https://github.com/tempoz/dotfiles)
  
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get remove vim vim-runtime gvim 
    sudo apt-get autoremove
    sudo apt-get install python3-dev clang make man curl git-lfs 7zip libgtk-3-dev vim-gtk3 liblua5.4-dev lua5.4 tig 

then run 

    mkdir ~/programs
    cd ~/programs
    git clone https://github.com/vim/vim.git
    cd vim

configure with the following options
    
    ./configure --enable-multibyte                                      \
                --enable-rubyinterp                                     \
                --disable-pythoninterp                                  \
                --enable-python3interp                                  \
                --with-python3-config-dir=(python3-config --configdir)  \
                --enable-perlinterp                                     \
                --enable-luainterp                                      \
                --disable-mzschemeinterp                                \
                --enable-tclinterp                                      \
                --with-tclsh=/usr/bin/tclsh                             \
                --with-features=huge                                    \
                --prefix=/usr/                                          \
                --enable-cscope                                         \
                --enable-autoservername='yes'                           \
                --disable-gui                                           \
                --enable-gui=gtk3

then compile with 

    cd /src
    make VIMRUNTIMEDIR=~/programs/vim/runtime
    sudo make install
    cd ~

#### [vim-plug](https://github.com/junegunn/vim-plug) install

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

enable with `:PlugInstall` in vim
