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
    source ~/.vimrc.bundles
endif

filetype plugin indent on " Turn on filetype plugins (:help filetype-plugin)

" Installation check.
NeoBundleCheck

" Tags file
set tags+=.git/tags

" Allow hiding buffers without saving first
set hidden

set showmatch           " show matching bracket (briefly jump)
set matchtime=2         " reduces matching paren blink time from the 5[00]ms def

" Show horizontal cursor
set cursorline

" disable folding
set nofoldenable
set foldlevelstart=99
set foldlevel=99
let g:DisableAutoPHPFolding = 1

set showmatch           " show matching bracket (briefly jump)
set matchtime=2         " reduces matching paren blink time from the 5[00]ms def

" tries to avoid those annoying "hit enter to continue" messages
" if it still doesn't help with certain commands, add a second <cr>
" at the end of the map command
set shortmess=a

" none of these should be word dividers, so make them not be
set iskeyword+=_,$,@,%,#

" Disable backup and swap files because they are just a PITA!
set nobackup
set noswapfile

" Set paste toggle 3x commas
map <leader>,, :set invpaste<CR>
set pastetoggle=<F10>

" Minimum lines to keep above and below cursor
set scrolloff=3

" Disable Ex mode Q key mapping
nnoremap Q <nop>

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" always switch to the current file directory.
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" Allow searching visually selected phrase
" TODO: split this into separate plugin
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

""
"" Helpers
""

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
"" General Mappings (Normal, Visual, Operator-pending)
""

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" Toggle paste mode
"nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
"imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nmap <leader>fef ggVG=

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
"nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

if has("gui_macvim") && has("gui_running")
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <D-]> >gv
  vmap <D-[> <gv

  nmap <D-]> >>
  nmap <D-[> <<

  omap <D-]> >>
  omap <D-[> <<

  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  " Bubble single lines
  nmap <D-Up> [e
  nmap <D-Down> ]e
  nmap <D-k> [e
  nmap <D-j> ]e

  " Bubble multiple lines
  vmap <D-Up> [egv
  vmap <D-Down> ]egv
  vmap <D-k> [egv
  vmap <D-j> ]egv

  " Map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt
else
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <A-]> >gv
  vmap <A-[> <gv

  nmap <A-]> >>
  nmap <A-[> <<

  omap <A-]> >>
  omap <A-[> <<

  imap <A-]> <Esc>>>i
  imap <A-[> <Esc><<i

  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  nmap <C-k> [e
  nmap <C-j> ]e

  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  vmap <C-k> [egv
  vmap <C-j> ]egv

  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>

  " Map Control-# to switch tabs
  map  <C-0> 0gt
  imap <C-0> <Esc>0gt
  map  <C-1> 1gt
  imap <C-1> <Esc>1gt
  map  <C-2> 2gt
  imap <C-2> <Esc>2gt
  map  <C-3> 3gt
  imap <C-3> <Esc>3gt
  map  <C-4> 4gt
  imap <C-4> <Esc>4gt
  map  <C-5> 5gt
  imap <C-5> <Esc>5gt
  map  <C-6> 6gt
  imap <C-6> <Esc>6gt
  map  <C-7> 7gt
  imap <C-7> <Esc>7gt
  map  <C-8> 8gt
  imap <C-8> <Esc>8gt
  map  <C-9> 9gt
  imap <C-9> <Esc>9gt
endif

" Escape and CTRL-C clear highlighting
nnoremap <esc> :noh<return><esc>
nnoremap <C-c> :noh<return><esc>

"Basically you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Keep search matches in the middle of the window.
" zz centers the screen on the cursor, zv unfolds any fold if the cursor
" suddenly appears inside a fold.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

" Fix home and end keybindings for screen, particularly on mac
" - for some reason this fixes the arrow keys too. huh.
map [F $
imap [F $
map [H g0
imap [H g0

" Navigate back from tag jump
nmap <C-[> :pop<CR>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Stupid shift key fixes
"cmap W w
"cmap WQ wq
"cmap wQ wq
"cmap Q q
"cmap Tabe tabe

" Slicker quicker window navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

"nmap <C-o> :ZoomWin<CR>
"nmap = 2<C-W>+
"nmap - 2<C-W>-

" Window navigation with stacking horizontal splits
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_
"map <C-L> <C-W>l<C-W>_
"map <C-H> <C-W>h<C-W>_

" Use tab to cycle tabs
"map <Tab> gt
"map <S-Tab> gT

" Quick close xml/html tag
imap ,/ </<C-X><C-O>

" Quickfix navigation
map <c-.> :lnext<CR>
map <c-,> :lprevious<CR>

" ReTab and StripWhiteSpaces
map <leader>rr :retab<CR> :StripWhiteSpaces<CR>

" New Tab ,ot
map <leader>ot :tabe<CR>

" Close Tab ,ct
map <leader>ct :tabclose<CR>

""
"" Command-Line Mappings
""

" Insert the current directory into a command-line path
cmap <C-P> <C-R>=expand("%:p:h") . "/"<CR>


""
"" Basic Setup
""

set nocompatible      " Use vim, no vi defaults
set relativenumber    " Show relative line numbers"
"set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8

""
"" Whitespace
""

set nowrap                        " don't wrap lines
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

set shiftwidth=4                " use indents of 4 spaces
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent

if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen

""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter
set magic       " change the way backslashes are used in search patterns

""
"" Wild settings
""

" TODO: Investigate the precise meaning of these settings
" set wildmode=list:longest,list:full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Disable Symfony cache files
set wildignore+=*/app/cache/*

" Disable Smarty cache files
set wildignore+=*/templates_c/*

""
"" Backup and swap files
""

"set backupdir=~/.vim/_backup//    " where to put backup files.
"set directory=~/.vim/_temp//      " where to put swap files.

""
" statusline
""

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  " Start the status line
  set statusline=%f\ %m\ %r
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

" File formats
set fileformat=unix     " file mode is unix
set fileformats=unix,dos,mac   " detects unix, dos, mac file formats in that order

" Min height for each window - allows stacking when using C-k and C-j
"set winminheight=0

""
"" Colour scheme & display
""

set background=dark

" Solarized specific settings
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
"colorscheme desert256
"colorscheme jellybeans
"colorscheme badwolf
"colorscheme herald
"colorscheme Tomorrow-Night
colorscheme solarized

" Force transparent backgrounds
hi Normal         ctermbg=none
hi NonText        ctermbg=none
hi Comment        ctermbg=none
hi Constant       ctermbg=none
hi String         ctermbg=none
hi Error          ctermbg=none
hi Identifier     ctermbg=none
hi Function       ctermbg=none
hi Ignore         ctermbg=none
hi PreProc        ctermbg=none
hi Special        ctermbg=none
hi Todo           ctermbg=none
hi Underlined     ctermbg=none
hi Statement      ctermbg=none
hi Operator       ctermbg=none
hi Delimiter      ctermbg=none
hi Type           ctermbg=none
hi Exception      ctermbg=none

" Do not make tabs show as red
hi RedundantWhitespace ctermbg=none
match RedundantWhitespace /\s\+$\|\t/

" Don't show dumb highlighting on so called spelling mistakes
hi clear SpellBad
" Use subtle underline instead
hi SpellBad cterm=underline

""
" Plugins
""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Gundo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <leader>g :GundoToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Undotree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>ut :UndotreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown specific tag settings
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

map <leader>rt :TagbarToggle<CR>
" Open Tagbar on Vim start
"autocmd vimenter * TagbarOpen
"autocmd VimEnter * nested :TagbarOpen
let g:tagbar_width = 30
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▾', '▸']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Command-T
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <C-t> :CommandT<CR>
"map <C-b> :CommandTBuffer<CR>
"let g:CommandTMatchWindowReverse = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Symfony
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:symfony_app_console_caller= "php"
"let g:symfony_app_console_path= "app/console"
let g:symfony_app_console_path= "~/Dev/git/bella/app/console"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Yankring
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:yankring_history_dir = '$HOME/tmp/vim'
" this is so that single char deletes don't end up in the yankring
let g:yankring_min_element_length = 2
let g:yankring_window_height = 14
nnoremap <leader>yr :YRShow<CR>

" this makes Y yank from the cursor to the end of the line, which makes more
" sense than the default of yanking the whole current line (we can use yy for
" that)
function! YRRunAfterMaps()
    nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction

" Map  yankring show to ,y yankring search to ,,y
"map <leader>y :YRShow<CR>
"map <leader><leader>y :YRSearch<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Yankstack
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nmap <C-p> <Plug>yankstack_substitute_older_paste
"nmap <C-n> <Plug>yankstack_substitute_newer_paste
"map <leader>y :Yanks<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Gitv
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             MySQLRun
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <leader>my :MySQLRun<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             VimCalc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <leader>cl :Calc<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              ack-grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ackprg="ack-grep -H --nocolor --nogroup --column --type-set=twig=.twig"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             GoldenView
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goldenview__enable_default_mapping = 0
let g:goldenview__enable_at_startup = 0
" 1. split to tiled windows
nmap <silent> <C-G>  <Plug>GoldenViewSplit
" 2. quickly switch current window with the main pane
" and toggle back
nmap <silent> <leader>gg <Plug>GoldenViewSwitchMain
nmap <silent> <leader>gf <Plug>GoldenViewSwitchToggle
"nmap <silent> <F8>   <Plug>GoldenViewSwitchMain
"nmap <silent> <S-F8> <Plug>GoldenViewSwitchToggle
" 3. jump to next and previous window
"nmap <silent> <C-N>  <Plug>GoldenViewNext
"nmap <silent> <C-P>  <Plug>GoldenViewPrevious

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Bufstop
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <C-b> :BufstopFast<CR>             " get a visual on the buffers
"map <leader>b :Bufstop<CR>             " get a visual on the buffers
"let g:BufstopAutoSpeedToggle = 1       " now I can press ,3,3,3 to cycle the last 3 buffers

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               PHPDebug                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :python debugger_run()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              SpeedDating                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap  <C-M>     <Plug>SpeedDatingUp
nmap  <C-X>     <Plug>SpeedDatingDown
xmap  <C-M>     <Plug>SpeedDatingUp
xmap  <C-X>     <Plug>SpeedDatingDown

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                PHPCtags                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_phpctags_bin='/home/gez/bin/phpctags'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               NERDTree                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>n :NERDTreeFocus<CR>:SignatureRefresh<CR>
map <leader>m :NERDTreeFind<CR>:SignatureRefresh<CR>
map <leader>er :NERDTreeToggle<CR>:SignatureRefresh<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let nerdtreeshowhidden=1
let nerdtreekeeptreeinnewtab=1
let NERDTreeMinimalUI=1

" Close NERDTree when leaving Vim - this prevents breaking session loading
autocmd VimLeave * NERDTreeClose

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"map <leader>n :Explore<CR>

"let g:netrw_altv          = 1
"let g:netrw_fastbrowse    = 2
"let g:netrw_keepdir       = 0
let g:netrw_liststyle     = 3
"let g:netrw_retmap        = 1
"let g:netrw_silent        = 1
let g:netrw_special_syntax= 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           HTML Autoclosetag
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"au FileType html.twig,xhtml,xml,smarty so ~/.vim/bundle/HTML-AutoCloseTag/ftplugin/html_autoclosetag.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable PHP CodeSniffer
let g:syntastic_phpcs_disable = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                PHPUnitqf                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:phpunit_args = "--configuration ../../../../../app/phpunit.vim.xml"
map <leader>pu :Test %<CR><CR>
map <leader>po :TestOutput<CR>L<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Vimpanel                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>ss :VimpanelSessionMake<CR>
map <leader>sl :VimpanelSessionLoad<CR>
cabbrev vp Vimpanel
cabbrev vl VimpanelLoad
cabbrev vc VimpanelCreate
cabbrev ve VimpanelEdit
cabbrev vr VimpanelRemove

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Fugitive                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gs :Gstatus<CR>
map <leader>gc :Gcommit<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                session                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" you also need to run :SaveSession once to create the default.vim session that
" will then be autoloaded/saved from then on

let g:session_autoload        = 'yes'
let g:session_autosave        = 'yes'
let g:session_default_to_last = 'yes'
let g:session_directory       = '~/tmp/vim/sessions'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                SuperTab                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SuperTab completion fall-back
"let g:SuperTabDefaultCompletionType='<c-x><c-i><c-p>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            phpDoc (pdv)                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
let g:pdv_template_dir = $HOME ."/.vim_templates/pdv/templates_snip"
"nnoremap <buffer> <C-p> :call pdv#DocumentCurrentLine()<CR>
nnoremap <leader>pp :call pdv#DocumentWithSnip()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            php-namespace                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>pn :call PhpInsertUse()<CR>
"inoremap <Leader>e <C-O>:call PhpExpandClass()<CR>
noremap <Leader>pe :call PhpExpandClass()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            php-cs-fixer                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If php-cs-fixer is in $PATH, you don't need to define line below
" let g:php_cs_fixer_path = "~/php-cs-fixer.phar" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "all"                  " which level ?
let g:php_cs_fixer_config = "sf21"            " configuration
let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_fixers_list = ""               " List of fixers
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            php-qa                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:phpqa_codesniffer_args = "--standard=Symfony2"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            MatchTagAlways                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'html.twig' : 1,
    \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                bufkill                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the arrows for something useful
" :BB switches to the previous buffer shown in the current window, :BF switches
" to the next one; it's like a buffer history for every window
noremap <right> :BF<cr>
noremap <left> :BB<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                YATE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tag Jump
noremap <Leader>tj :YATE<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetDirectories=["custom_snippets"]
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"let g:UltiSnipsListSnippets="<c-u>"
let g:UltiSnipsDontReverseSearchPath="1"

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Thumbnail
map <leader><tab> :Thumbnail<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Behat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let feature_filetype='behat'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Powerline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Powerline fancy patched font goodness
let g:Powerline_symbols = 'fancy'

if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<C-t>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.projectroot']
let g:ctrlp_match_window = 'bottom,order:ttb,min:8,max:20'
map <C-b> ::CtrlPMRUFiles<CR>

let g:ctrlp_extensions = ['funky']
map <Leader>tf :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
map <Leader>tF :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
map <Leader>tm :CtrlPModified<CR>
map <Leader>tM :CtrlPBranch<CR>
map <Leader>tc :CtrlPCmd<CR>
map <Leader>ty :CtrlPYank<CR>
map <Leader>tt :CtrlPMenu<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             CtrlP tjump
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <c-]> :CtrlPtjump<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Unite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <C-t> :Unite -start-insert file<cr>
"nnoremap <C-t> :<C-u>Unite -start-insert file_rec/async:!<CR>
"let g:unite_force_overwrite_statusline = 0
"call unite#custom#source('file,file/new,buffer,file_rec',
    "\ 'matchers', 'matcher_fuzzy')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Breeze
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd Filetype twig,html,smarty map ]] :BreezeJumpF<cr>
autocmd Filetype twig,html,smarty map [[ :BreezeJumpB<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Todo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" todo.vim default highlight groups, feel free to override as wanted
hi link TodoTitle Title
hi link TodoTitleMark Normal
hi link TodoItem Special
hi link TodoItemAdditionalText Comment
hi link TodoItemCheckBox Identifier
hi link TodoItemDone Ignore
hi link TodoComment Comment " explicit comments must be enabled for this

" define like this to enable explicit comments
" comments then start with //
let g:TodoExplicitCommentsEnabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:ycm_cache_omnifunc = 0
"let g:ycm_collect_identifiers_from_tags_files = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Vertigo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Space>j :<C-U>VertigoDown n<CR>
vnoremap <silent> <Space>j :<C-U>VertigoDown v<CR>
onoremap <silent> <Space>j :<C-U>VertigoDown o<CR>
nnoremap <silent> <Space>k :<C-U>VertigoUp n<CR>
vnoremap <silent> <Space>k :<C-U>VertigoUp v<CR>
onoremap <silent> <Space>k :<C-U>VertigoUp o<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Multiedit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert a disposable marker after the cursor
nmap <leader>ma :MultieditAddMark a<CR>

" Insert a disposable marker before the cursor
nmap <leader>mi :MultieditAddMark i<CR>

" Make a new line and insert a marker
nmap <leader>mo o<Esc>:MultieditAddMark i<CR>
nmap <leader>mO O<Esc>:MultieditAddMark i<CR>

" Insert a marker at the end/start of a line
nmap <leader>mA $:MultieditAddMark a<CR>
nmap <leader>mI ^:MultieditAddMark i<CR>

" Make the current selection/word an edit region
vmap <leader>m :MultieditAddRegion<CR>
nmap <leader>mm viw:MultieditAddRegion<CR>

" Restore the regions from a previous edit session
nmap <leader>mu :MultieditRestore<CR>

" Move cursor between regions n times
map ]m :MultieditHop 1<CR>
map [m :MultieditHop -1<CR>

" Start editing!
nmap <leader>M :Multiedit<CR>

" Clear the word and start editing
nmap <leader>C :Multiedit!<CR>

" Unset the region under the cursor
nmap <silent> <leader>md :MultieditClear<CR>

" Unset all regions
nmap <silent> <leader>mr :MultieditReset<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           PHPComplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:phpcomplete_complete_for_unknown_classes = 0
let g:phpcomplete_parse_docblock_comments = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Neocomplecache
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

inoremap <expr><Tab>  neocomplcache#start_manual_complete()

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


""
"" Final inclusion of local config
""

" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

""
"" Final inclusion of local config
""

" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
