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

" Key remaps
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :TagbarToggle<CR>
nmap <F4> :BufExplorerHorizontalSplit<CR>
nmap <silent> <F5> :!tmux splitw -v -l 5<CR><CR>

" GRB: use fancy buffer closing that doesn't close the split
:nnoremap <silent> <S-Left> :bprevious<CR>
:nnoremap <silent> <S-Right> :bnext<CR>
:noremap <silent> <C-Left> b
:noremap <silent> <C-Right> w

" :w!! sudo saves the file
cmap w!! w !sudo tee % >/dev/null

" NERDTree options
let NERDTreeAutoCenter = 1
let NERDTreeCaseSensitiveSort = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeMouseMode = 1
let NERDTreeIgnore=['.*\.o$']
let NERDTreeIgnore+=['.*\~$']
let NERDTreeIgnore+=['.*\.out$']
let NERDTreeIgnore+=['.*\.so$', '.*\.a$']
let NERDTreeIgnore+=['.*\.pyc$']
let NERDTreeIgnore+=['.*\.class$']

" Bufexplorer options
let g:bufExplorerSplitBelow=1

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '»'
let g:airline_exclude_preview = 1
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '»'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '«'
"let g:airline_linecolumn_prefix = '␤ '
let g:airline_symbols.linenr = '␤ '
"let g:airline_linecolumn_prefix = '¶ '
"let g:airline_branch_prefix = '⎇ '
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.paste = 'ρ'
"let g:airline_paste_symbol = 'Þ'
"let g:airline_paste_symbol = '∥'

" Jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 0

" Tmux integration
if &term =~ '^screen'
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Close tmux when exiting vim
autocmd VimLeave * silent !tmux killp -a

" Custom file types
au BufRead,BufNewFile *.md set filetype=markdown

" Automatic commands
autocmd VimEnter *.c,*.cpp,*.h,*.java,*.py NERDTree
autocmd FileType c,cpp,h,java,python nested :TagbarOpen

" Autoload changes in .vimrc
autocmd BufWritePost .vimrc source $MYVIMRC

