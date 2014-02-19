""
"" Vim custom config
""

let mapleader = ","

" Force using bash shell - fixes issues when using fish
set shell=/bin/bash

set nocompatible
filetype off

" NeoBundle
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Include a bundles config file
if filereadable(expand("~/.vimrc.bundles.local"))
    source ~/.vimrc.bundles.local
elseif filereadable(expand("~/.vimrc.bundles"))
    "source ~/.vimrc.bundles
endif

" Turn on filetype plugins (:help filetype-plugin)
filetype plugin indent on

" Installation check.
NeoBundleCheck

""
"" Helpers
""

" Allow searching visually selected phrase
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        execute "Ack " . l:pattern . ' %'
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Some file types should wrap their text
function! s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction

""
"" File types
""

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make setlocal noexpandtab

  " Make sure all mardown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

""
"" Key mappings
""

if filereadable(expand("~/.vimrc.mappings"))
    source ~/.vimrc.mappings
endif

""
"" Settings
""

if filereadable(expand("~/.vimrc.settings"))
    source ~/.vimrc.settings
endif


""
"" Colour scheme & display
""

if filereadable(expand("~/.vimrc.display"))
    source ~/.vimrc.display
endif

""
"" Final inclusion of local config
""

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
