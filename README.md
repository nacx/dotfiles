dotfiles and Vim configuration
==============================

These are my dotfiles to configure Git and Vim, combined with Tmux, to have a split pane with a shell where I can run commands.

<a href="https://github.com/nacx/dotfiles/raw/master/vim.png"><img src="https://github.com/nacx/dotfiles/raw/master/vim.png" height="200"/></a>

These are the used Vim plugins:

* **bufexplorer**: Easily show the list of buffers and switch between them.
* **deoplete**: Autocompletion support.
* **deoplete-go**: Golang language support for deoplete.
* **nerdtree**: The file explorer.
* **nvim-yarp**: Neovim porting for Vim8. Used to enable Deoplete in plain Vim.
* **tagbar**: To show the structure of the files and easily jump to variables, methods, etc.
* **tcomment**: Useful to comment/uncomment code.
* **vim-airline**: A fantastic status bar.
* **vim-autoclose**: Automatically close code blocks, etc.
* **vim-fugitive**: Git integration.
* **vim-go**: Golang integration.
* **vim-hug-neovim-rpc**: Compatibility layer for Neovim RPC client for Vim8.
* **vim-pathogen**: The plugin loader.
* **vim-sensible**: Common defaults for the .vimrc.
* **vim-signify**: Show the git stats when editing files.
* **xmledit**: Automatically close tags in xml files.

Prerequisites
-------------

In order to use the Vim plugins the following pieces have to be installed manually:

* tmux
* Exuberant ctags >= 5.5
* Python3 and its development libraries.

Installation
------------

There is no automatic way to install this, but only a few links need to be created. You can install all the plugins and create the links as follows:

    # Install Neovim python3 support
    pip3 install neovim

    # Clone the repo
    git clone https://github.com/nacx/dotfiles.git
    cd doftiles

    # Clone the plugins
    git submodule update --init

    # The 'deoplete-go' plugin is platform dependent and needs to be compiled:
    cd .vim/bundle/deoplete-go
    make

    # Create the symbolic links in your home
    cd ~
    ln -s dotfiles/.tmux.conf
    ln -s dotfiles/.vimrc
    ln -s dotfiles/.vim

That will leave everything in place to run vim with all the plugins. In order to enable the terminal, you will have to open vim in a tmux session. This can be automated by adding teh following lines to the *.barhrc* file:

    # Open Vim with tmux
    function vim_tmux() { tmux new -d "vim $*" \; attach; }
    alias vim='vim_tmux'

Install Go commands
-------------------

Once you have everything configured, you can install all Go commands used by *vim-go* by entering Vim and running:

    :GoInstallBinaries

Usage cheat sheet
-----------------

The following keys have been mapped by default:

* **F2**: Toggle NERDTree.
* **F3**: Toggle Tagbar (it is opened by default in certain source ccode files).
* **F4**: Open a vertical split and show the list of existing buffers.
* **F5**: Open a shell in a tmux split.
* **Shift-Left/Right**: Change to the previous/next buffer.
* **\<Ctrl-x\>\<Ctrl-o\>**: In 'insert mode' opens the autocompletion popup.
