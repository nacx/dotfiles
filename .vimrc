" Load Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Use :help <option> to see the docs
set expandtab
set shiftwidth=4
set softtabstop=4
set smartindent
set incsearch
set ignorecase
set smartcase
set mouse=a
set hidden
set wildmode=list:longest
set number
set title
set ruler
set nospell

" Customize view
sy on
set t_Co=256
colorscheme nacx

" Plugin key remaps
map <F2> <ESC>:NERDTreeToggle<RETURN>
nmap <F3> :TagbarToggle<CR>

" NERDTree options
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

" Automatic commands
autocmd VimEnter *.c,*.cpp,*.h,*.java,*.py NERDTree
autocmd FileType c,cpp,h,java,python nested :TagbarOpen

" Autoload changes in .vimrc
autocmd BufWritePost .vimrc source $MYVIMRC

