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

" Enable omnicompletion
set ofu=syntaxcomplete#Complete
set completeopt=longest,menuone 
" Change the behaviour of the <Enter> key in popmenu
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Add the C-Space mapping to enable omnicompletion
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" Move the cursor to the windows
noremap <silent> <Leader>h :wincmd h<CR>
noremap <silent> <Leader>j :wincmd j<CR>
noremap <silent> <Leader>k :wincmd k<CR>
noremap <silent> <Leader>l :wincmd l<CR>


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


" ---------------------------------------------
"  Filetypes
" ---------------------------------------------
" XML
" Autoload files ended with .xml with the xmlheader 
autocmd BufNewFile *.xml source ~/.vim/ftplugin/xml.vim

" PYTHON
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd BufWritePost *.py call Flake8()

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
nnoremap <silent><F3> :TlistToggle<RETURN>

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

" let Tlist_Auto_Open = 1
let Tlist_Auto_Update = 1
let Tlist_Use_Right_Window = 1
autocmd VimEnter *.java Tlist
"autocmd VimEnter *.c Tlist
autocmd VimEnter *.h Tlist
autocmd VimEnter *.vim Tlist


" Autoload changes in .vimrc
autocmd BufWritePost .vimrc source $MYVIMRC

