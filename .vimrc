" Load Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" -----------------------------------------------
" CUSTOMIZE BEHAVIOUR
" -----------------------------------------------

" Tabs to spaces.
set expandtab shiftwidth=4 softtabstop=4 smarttab smartindent

" Encoding options.
set encoding=utf-8 fileencoding=utf-8

" Search options.
set incsearch ignorecase smartcase

" Mouse support
set mouse=a

" Manage multiple buffers effectively
set hidden

" Let see all the options when press <TAB> in command line
set wildmenu
set wildmode=list:longest

" ----------------------------------------------
"  CUSTOMIZE VIEW
" ----------------------------------------------

" Set theme.
sy on
set t_Co=256
colorscheme nacx

" Show number lines
set number title ruler

" Load custom filetypes
so ~/.vim/customfiletypes.vim

" SPELL CHECK
"
set nospell
" autocmd FileType txt set spell
" autocmd FileType c set spell
" autocmd FileType h set spell
" autocmd FileType java set spell

" ----------------------------------------------
"  PLUGINS
"  ---------------------------------------------

" Enable filetype plugins
filetype plugin indent on

" NerdTree Plugin
map <F2> <ESC>:NERDTreeToggle<RETURN>

" Set NERDTree option customize
let NERDTreeAutoCenter = 1
let NERDTreeCaseSensitiveSort = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeMouseMode = 1
let NERDTreeShowBookmarks = 1
let NERDTreeIgnore=['.*\.o$']
let NERDTreeIgnore+=['.*\~$']
let NERDTreeIgnore+=['.*\.out$']
let NERDTreeIgnore+=['.*\.so$', '.*\.a$']
let NERDTreeIgnore+=['.*\.pyc$']
let NERDTreeIgnore+=['.*\.class$']
autocmd VimEnter *.java NERDTree
"autocmd VimEnter *.c NERDTree
autocmd VimEnter *.h NERDTree
autocmd VimEnter *. wincmd p

" Autoload changes in .vimrc
autocmd BufWritePost .vimrc source $MYVIMRC

