"
" *************************************************************
" Filename : ~/vim/customfiletypes.vim
" See the document by typing :help autocmd within vim session
" see also the doc at /usr/share/vim/doc/autocmd.txt
" This file will setup the autocommands for new filetypes 
" using the existing syntax-filetypes.
" For example when you open foo.prc it will use syntax of plsql
" Basically does :set filetype=prc inside vim
" Add a line in ~/.gvimrc as below:
" so ~/vim/customfiletypes.vim
"
" *************************************************************
augroup filetype
        au!
        au! BufRead,BufNewFile *.java*    set filetype=java
        au! BufRead,BufNewFile *.scala*    set filetype=java
augroup END

