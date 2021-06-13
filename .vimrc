" Automatically install the plugin manager if missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'tpope/vim-sensible'
Plug 'mhinz/vim-signify'
Plug 'sukima/xmledit'
Plug 'vim-airline/vim-airline'
Plug 'jacoborus/tender.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'
call plug#end()

" Use :help <option> to see the docs
set encoding=utf-8
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
set hlsearch
set exrc

" Color theme
sy on
set t_Co=256
colorscheme tender
" Override the highlight color so it shows better in nerdtree with high
" contrast
hi CursorLine guibg=#444444 gui=bold ctermbg=237 cterm=none

" Key remaps
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :TagbarToggle<CR>
nmap <silent> <F4> :!tmux splitw -v -l 5<CR><CR>
nmap f :NERDTreeFind<CR>

" Use fancy buffer closing that doesn't close the split
:nnoremap <silent> <S-Left> :bprevious<CR>
:nnoremap <silent> <S-Right> :bnext<CR>
:noremap <silent> <C-Left> b
:noremap <silent> <C-Right> w

" Replace strings in local or global scope
" https://stackoverflow.com/a/597932/3540564
:nnoremap gr gd[{V%:s/<C-R>///gc<Left><Left><Left>
:nnoremap gR gD:s/<C-R>///gc<Left><Left><Left>

" :w!! sudo saves the file
cmap w!! w !sudo tee % >/dev/null

" NERDTree options
let NERDTreeAutoCenter = 1
let NERDTreeCaseSensitiveSort = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeMouseMode = 1
"let NERDTreeDirArrows = 1
let NERDTreeIgnore=['.*\.o$']
let NERDTreeIgnore+=['.*\~$']
let NERDTreeIgnore+=['.*\.out$']
let NERDTreeIgnore+=['.*\.so$', '.*\.a$']
let NERDTreeIgnore+=['.*\.pyc$']
let NERDTreeIgnore+=['.*\.class$']

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '»'
let g:airline_exclude_preview = 1
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '»'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '«'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = '␤ '
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.paste = 'ρ'

" Autocomplete configuration
"set completeopt-=preview
set completeopt+=noinsert,longest,menuone
if has("patch-7.4.314")
    set shortmess+=c
endif
" Close the preview window after completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Enter just selects the item in the autocomplete menu
" http://vim.wikia.com/wiki/VimTip1386
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Map Ctrl+Space to autocomplete
" https://coderwall.com/p/cl6cpq/vim-ctrl-space-omni-keyword-completion
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" Gutentag
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git', 'go.mod']
let g:gutentags_modules = ['ctags']
let g:gutentags_project_root_finder = ''
let g:gutentags_add_ctrlp_root_markers = 0
let g:gutentags_exclude_project_root = ['/usr/local', '/opt/homebrew']
let ctags_cache = expand('~/.cache/vim/ctags/')
let g:gutentags_cache_dir = ctags_cache
function Ctags_project_file()
    let l:
    try
        let l:project_ctags = gutentags#get_project_root(getcwd())
        let l:project_ctags = strpart(substitute(l:project_ctags, "/", "-", "g"), 1) . '-tags'
    catch
        let l:project_ctags = ''
    endtry
    return l:project_ctags
endfunction
:execute 'set tags=' . ctags_cache . Ctags_project_file()

" FZF
let g:fzf_layout = { 'down': '30%' }
:nnoremap sf :Files<CR>
:nnoremap sb :Buffers<CR>
:nnoremap st :Tags<CR>
:nnoremap sc :Commits<CR>

" Go
let g:go_fmt_command = "goimports"
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_doc_popup_window = 1
:nnoremap gdoc :GoDoc<CR>
:nnoremap gs :GoInfo<CR>
:nnoremap gdb :GoDebugBreakpoint<CR>
:nnoremap gdi :GoDebugStep<CR>
:nnoremap gdn :GoDebugNext<CR>
:nnoremap gdo :GoDebugStepOut<CR>
:nnoremap gdr :GoDebugContinue<CR>
let g:go_debug_windows = {
    \ 'vars':       'leftabove 40vnew',
    \ 'stack':      'botright 15new',
    \ 'goroutines': 'leftabove vnew',
    \ 'out':        'botright 5new',
\ }

" Tmux integration
if &term =~ '^screen'
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Close tmux when exiting vim
autocmd VimLeave * silent !tmux kill-session -t $VIM_SESSION

" Custom file types
au BufRead,BufNewFile *.md set filetype=markdown
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

" Better help navigation
autocmd FileType help nnoremap <buffer> <CR> <C-]>
autocmd FileType help nnoremap <buffer> <BS> <C-T>
autocmd FileType help nnoremap <buffer> o /'\l\{2,\}'<CR>
autocmd FileType help nnoremap <buffer> O ?'\l\{2,\}'<CR>
autocmd FileType help nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
autocmd FileType help nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>

" Automatic commands
"autocmd VimEnter *.c,*.cpp,*.h,*.java,*.py,*.go NERDTree
autocmd FileType c,cpp,h,java,python,go nested :TagbarOpen

" QuickFix window always at the bottom
autocmd FileType qf wincmd J

" Two space indent in Ruby
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2

" Autoload changes in .vimrc
" Commented because for some reason, when this is set vim always leaves
" the .vimrc.swp file without deleting it
"autocmd BufWritePost .vimrc source $MYVIMRC

